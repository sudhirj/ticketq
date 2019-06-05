# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    response.headers['Content-Type'] ||= 'text/csv'
    response.headers['Content-Disposition'] = "attachment; filename=#{['all', DateTime.current].join(' ').parameterize}.csv"
    response.headers['Content-Transfer-Encoding'] = 'binary'
    response.headers['Last-Modified'] = Time.current.ctime.to_s

    self.response_body = Enumerator.new do |yielder|
      yielder << [
        'Show Time',
        'Show Name',
        'Denomination',
        'Allocated',
        'Sold',
        'Online Occupancy',
        'Revenue'
      ].to_csv
      Denomination.all.each do |denom|
        yielder << [
          denom.performance.showtime.to_s,
          denom.show.name,
          [denom.name, denom.price].join(' / '),
          denom.allocated_count,
          denom.confirmed_count,
          ((denom.confirmed_count.to_f * 100) / denom.allocated_count.to_f).round.to_s + '%',
          denom.confirmed_count * denom.price
        ].to_csv
      end
    end
  end


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
            [booking.denomination.name, booking.denomination.price].join(' / '),
            booking.count,
            booking.name,
            ['M', booking.mobile].join(':'),
            booking.email,
            booking.created_at.to_s
          ].to_csv
        end
      end
    end
  end
end