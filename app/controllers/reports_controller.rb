# frozen_string_literal: true

class ReportsController < ApplicationController
  def show
    performance = Performance.find(params[:id])

    response.headers['Content-Type'] ||= 'text/csv'
    response.headers['Content-Disposition'] = "attachment; filename=#{[performance.showdate_display, performance.showtime_display].join(' ').parameterize}.csv"
    response.headers['Content-Transfer-Encoding'] = 'binary'
    response.headers['Last-Modified'] = Time.current.ctime.to_s

    self.response_body = Enumerator.new do |yielder|
      yielder << [
        'Code',
        'Denomination',
        'Count',
        'Name',
        'Mobile',
        'Email',
        "Booking Time / Until #{DateTime.current}"
      ].to_csv
      performance.denominations.each do |denom|
        denom.bookings.confirmed.each do |booking|
          yielder << [
            booking.shortcode,
            [booking.denomination.name, booking.denomination.display_price].join(' / '),
            booking.count,
            booking.name,
            booking.mobile,
            booking.email,
            booking.created_at.to_s
          ].to_csv
        end
      end
    end
  end
end
