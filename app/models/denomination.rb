class Denomination < ApplicationRecord
  belongs_to :performance

  # The sum of all allocations must be equal to the sum of all bookings.
  has_many :allocations
  has_many :bookings

  delegate :company, to: :performance
  delegate :show, to: :performance
  delegate :venue, to: :performance

  data_accessors :name


  def allocated_count
    allocations.sum(:count)
  end

  def confirmed_count
    bookings.where(confirmed: true).sum(:count)
  end

  def blocked_count
    bookings.where(confirmed: false, active: true).sum(:count)
  end

  def available_count
    allocated_count - confirmed_count - blocked_count
  end

  def can_book?(wanted_count)
    available_count >= wanted_count
  end

end
