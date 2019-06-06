# frozen_string_literal: true

class BookingsController < ApplicationController
  def create
    denom = Denomination.find(params[:denom])
    unless denom.can_book?(count_param) && !denom.performance.closed
      flash[:notice] = 'Tickets Not Available!'
      redirect_back fallback_location: performance_link_path(denom.company.slug, denom.show.slug, denom.venue.slug, denom.performance.showtime.to_formatted_s(:iso8601))
      return
    end
    booking = denom.bookings.create! count: count_param
    booking.update_attributes! name: params[:name], email: params[:email], mobile: params[:mobile]
    booking.ensure_rp_invoice
    redirect_to booking_link_path booking.receipt
  end

  def show
    @booking = full_loaded_booking.find_by!(receipt: params[:receipt])
    @booking.refresh if @booking.active && !@booking.confirmed
  end

  private

  def count_param
    params[:count].to_i
  end

  def full_loaded_booking
    Booking.includes(denomination: { performance: { show: [:company], venue: [] } })
  end
end
