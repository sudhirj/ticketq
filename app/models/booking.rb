# frozen_string_literal: true

class Booking < ApplicationRecord
  RECEIPT_ALPHABET = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789'
  belongs_to :denomination
  scope :confirmed, -> { where(confirmed: true) }
  scope :blocked, -> { where(confirmed: false, active: true) }

  data_accessors :name, :mobile, :email

  before_save :set_status

  def set_status
    self.confirmed = rp_data.dig('status') == 'paid'
    self.active = false if rp_data.dig('status') == 'expired'
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
                           expire_by: 30.minutes.from_now.to_i
                         }.to_json,
                         headers: rp_headers,
                         basic_auth: rp_auth)

    return if resp.code != 200

    self.rp_data = resp.parsed_response
    save!
  end

  def terms
    %(* This invoice is valid only if paid.
* Please pick up your tickets at the counter before the show at least 15 minutes before the show starts.
* You don't need to print this invoice on paper, an email / SMS is enough.)
  end

  def description
    %{Tickets for #{denomination.performance.show.name} on #{denomination.performance.showtime.strftime('%A')}, #{denomination.performance.showtime.to_date.to_s(:long)} at #{denomination.performance.showtime.strftime('%I:%M %p')} at #{denomination.performance.venue.name} (#{denomination.performance.venue.area}). After payment, this invoice can be exchagned for the tickets at the counter before the show.}
  end

  def refresh
    resp = HTTParty.get('https://api.razorpay.com/v1/invoices',
                        query: {
                          receipt: receipt_id
                        },
                        headers: rp_headers,
                        basic_auth: rp_auth)
    return if resp.code != 200
    return if resp.parsed_response['count'].zero?

    self.rp_data = resp.parsed_response['items'].first
    save!
  end

  def receipt_id
    ['TQ', timecode, short_id[0..5]].join('-')
  end

  def timecode
    yymmddhhmm = denomination.performance.showtime.strftime('%y%m%d%H%M').to_i
    ShortUUID.convert_decimal_to_alphabet yymmddhhmm, RECEIPT_ALPHABET.chars
  end

  def short_id
    ShortUUID.shorten id, RECEIPT_ALPHABET.chars
  end

  def rp_auth
    { username: 'rzp_test_gn9vzTBHdzvvBt', password: 'IDWBzrnB3LxEBfGkm1EjhASw' }
  end

  def rp_headers
    { "Content-Type": 'application/json' }
  end

  def url
    rp_data.dig('short_url')
  end
end
