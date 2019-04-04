class BookingsController < ApplicationController
  def create
    denom = Denomination.find(params[:denom])
    booking = denom.bookings.create! count: params[:count].to_i
    booking.update_attributes! name: params[:name], email: params[:email], mobile: params[:mobile]
    booking.ensure_rp_invoice
    redirect_to booking.url
  end
end
