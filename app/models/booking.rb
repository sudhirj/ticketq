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
                           type: 'link',
                           amount: count * denomination.price * 100,
                           currency: 'INR',
                           description: "Test description\nWith multi lines. \nSo Haiku",
                           receipt: receipt_id,
                           terms: "The rain in spain falls mainly\nIn the plain",
                           expire_by: 15.minutes.from_now.to_i
                         },
                         headers: rp_headers,
                         basic_auth: rp_auth)
    return if resp.code != 200

    self.rp_data = resp.parsed_response
    save!
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
    {}
  end
end
