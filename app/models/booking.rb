# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :denomination
  scope :confirmed, -> { where(confirmed: true) }
  scope :blocked, -> { where(confirmed: false, active: true) }
end
