# frozen_string_literal: true

class BookingsController < ApplicationController
  def create
    denom = Denomination.find(params[:denom])
    booking = denom.bookings.create! count: params[:count].to_i
    booking.update_attributes! name: params[:name], email: params[:email], mobile: params[:mobile]
    booking.ensure_rp_invoice
    redirect_to booking_link_path booking.receipt
  end

  def show
    @booking = full_loaded_booking.find_by!(receipt: params[:receipt])
    @booking.refresh if @booking.active && !@booking.confirmed
  end

  private

  def full_loaded_booking
    Booking.includes(denomination: { performance: { show: [:company], venue: [] } })
  end
end
