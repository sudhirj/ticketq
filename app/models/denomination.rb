class Denomination < ApplicationRecord
  belongs_to :performance

  # The sum of all allocations must be equal to the sum of all bookings.
  has_many :allocations
  has_many :bookings


end
