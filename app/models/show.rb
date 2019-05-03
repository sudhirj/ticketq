class Show < ApplicationRecord
  belongs_to :company
  has_many :performances
  store_accessor :data, :name, :tagline, :cast, :crew, :about, :warning, :terms,
                 :poster, :runtime_hours, :runtime_minutes, :intermission

  def runtime_display
    parts = []
    parts << [runtime_hours, 'hour'.pluralize(runtime_hours)].join(' ') unless runtime_hours.zero?
    parts << [runtime_minutes, 'minute'.pluralize(runtime_minutes)].join(' ') unless runtime_minutes.zero?
    parts << (intermission ? 'with intermission' : 'without intermission')
    parts.join(' ')
  end

  def runtime_hours
    super.to_i
  end

  def runtime_minutes
    super.to_i
  end

end
