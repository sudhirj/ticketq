namespace :bookings do
  task update: [:environment] do
    Booking.blocked.find_each(&:refresh)
  end
end
