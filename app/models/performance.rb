class Performance < ApplicationRecord
  belongs_to :show
  belongs_to :venue

  has_many :denominations

  before_save :normalize_showtime

  def normalize_showtime
    self.showtime = showtime.beginning_of_minute
  end
end
