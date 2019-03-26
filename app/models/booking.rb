# frozen_string_literal: true

class Booking < ApplicationRecord
  def rp_init
    return if rp_data.dig('id').present?
  end

  def rp_client
    @rp_client ||= begin
      Razorpay.setup ENV.fetch('RP_KEY_ID'), ENV.fetch('RP_KEY_SECRET')
      Razorpay.headers = { 'x-razorpay-account' => ENV.fetch('RP_ACCOUNT') }
    end
  end
end
