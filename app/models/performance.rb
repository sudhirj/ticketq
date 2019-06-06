class Performance < ApplicationRecord
  belongs_to :show
  belongs_to :venue

  delegate :company, to: :show

  store_accessor :data, :closed


  has_many :denominations

  before_save :normalize_showtime

  def normalize_showtime
    self.showtime = showtime.beginning_of_minute
  end

  def showdate_display
    "#{showtime.strftime('%A')}, #{showtime.to_date.to_s(:long)}"
  end

  def showtime_display
    showtime.strftime('%I:%M %p')
  end
end
