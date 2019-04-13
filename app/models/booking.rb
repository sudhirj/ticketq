# frozen_string_literal: true

class Booking < ApplicationRecord
  RECEIPT_ALPHABET = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789'
  belongs_to :denomination

  delegate :company, to: :denomination
  delegate :show, to: :denomination
  delegate :performance, to: :denomination
  delegate :venue, to: :denomination


  scope :confirmed, -> {where(confirmed: true)}
  scope :blocked, -> {where(confirmed: false, active: true)}

  data_accessors :name, :mobile, :email

  before_save :set_status

  def set_status
    self.confirmed = rp_data.dig('status') == 'paid'
    self.active = false if rp_data.dig('status') == 'expired'
    self.receipt = rp_data.dig('receipt')
  end

  def ensure_rp_invoice
    resp = HTTParty.post('https://api.razorpay.com/v1/invoices',
                         body: {
                             type: 'invoice',
                             line_items: [
                                 amount: denomination.price * 100,
                                 name: denomination.name,
                                 currency: 'INR',
                                 quantity: count
                             ],
                             customer: {
                                 name: name,
                                 email: email,
                                 contact: mobile
                             },
                             description: description,
                             receipt: receipt_id,
                             terms: terms,
                             expire_by: expire_at.to_i,
                             sms_notify: 0,
                             email_notify: 0
                         }.to_json,
                         headers: rp_headers,
                         basic_auth: rp_auth)

    if resp.code != 200
      logger.error resp
      raise 'Razorpay Error'
    end

    self.rp_data = resp.parsed_response
    save!
  end

  def terms
    %(* This invoice is valid only if paid.
* Please pick up your tickets at the counter before the show at least 15 minutes before the show starts.
* You don't need to print this invoice on paper, an email / SMS is enough.)
  end

  def expire_at
    created_at + 30.minutes
  end

  def description
    %{#{count} #{denomination.name} #{'ticket'.pluralize(count)} for #{denomination.performance.show.name} on #{showdate_display} at #{showtime_display} at #{denomination.performance.venue.name} (#{denomination.performance.venue.area}).}
  end

  def showdate_display
    "#{denomination.performance.showtime.strftime('%A')}, #{denomination.performance.showtime.to_date.to_s(:long)}"
  end

  def showtime_display
    denomination.performance.showtime.strftime('%I:%M %p')
  end

  def refresh
    return if confirmed || !active

    resp = HTTParty.get("https://api.razorpay.com/v1/invoices/#{rp_data.dig('id')}", headers: rp_headers, basic_auth: rp_auth)
    return if resp.code != 200

    self.rp_data = resp.parsed_response
    save!
  end

  def receipt_id
    ['TQ',performance_shortcode, denom_shortcode, shortcode].join('-')
  end

  def performance_shortcode
    ShortUUID.shorten(performance.id, RECEIPT_ALPHABET.chars)[0..5]
  end

  def denom_shortcode
    ShortUUID.shorten(denomination.id, RECEIPT_ALPHABET.chars)[0..2]
  end

  def shortcode
    short_id[0..5]
  end

  def timecode
    yymmddhhmm = denomination.performance.showtime.strftime('%y%m%d%H%M').to_i
    ShortUUID.convert_decimal_to_alphabet yymmddhhmm, RECEIPT_ALPHABET.chars
  end

  def short_id
    ShortUUID.shorten id, RECEIPT_ALPHABET.chars
  end

  def rp_auth
    {username: ENV.fetch('RP_KEY_ID'), password: ENV.fetch('RP_KEY_SECRET')}
  end

  def rp_headers
    {
        'Content-Type': 'application/json',
        'x-razorpay-account': company.rp_account
    }
  end

  def url
    rp_data.dig('short_url')
  end
end
