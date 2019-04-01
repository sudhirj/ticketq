# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :denomination
  scope :confirmed, -> { where(confirmed: true) }
  scope :blocked, -> { where(confirmed: false, active: true) }

  before_save :set_status

  def set_status
    self.confirmed = rp_data.dig('status') == 'paid'
    self.active = false if rp_data.dig('status') == 'expired'
  end

  def ensure_rp_invoice
    resp = HTTParty.post('https://api.razorpay.com/v1/invoices',
                         body: {
                           type: 'invoice',
                           "line_items": [
                             amount: denomination.price * 100,
                             name: 'Ticket',
                             currency: 'INR',
                             quantity: count
                           ],
                           customer: {
                             name: 'Sudhir',
                             email: 'sudhir.j@gmail.com',
                             contact: '9789063705'
                           },
                           description: description,
                           receipt: receipt_id,
                           terms: terms,
                           expire_by: 20.minutes.from_now.to_i
                         }.to_json,
                         headers: rp_headers,
                         basic_auth: rp_auth)
    pp resp.request
    pp resp
    return if resp.code != 200

    self.rp_data = resp.parsed_response
    save!
  end

  def terms
    %(
Please pick up your tickets at the counter 30 minutes before the show.
You can present the paid copy of this invoice to claim your tickets - an email and SMS will be sent to you on payment.
    )
  end

  def description
    %(
Tickets for the show.
    )
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
    ShortUUID.shorten id, 'ABCDEFGHJKMNPQRSTUVWXYZ23456789'.chars
  end

  def rp_auth
    { username: 'rzp_test_gn9vzTBHdzvvBt', password: 'IDWBzrnB3LxEBfGkm1EjhASw' }
  end

  def rp_headers
    { "Content-Type": 'application/json' }
  end
end
