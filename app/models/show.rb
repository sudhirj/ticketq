class Show < ApplicationRecord
  belongs_to :company
  has_many :performances
  data_accessors :name, :tagline, :cast, :crew, :about, :runtime, :terms, :poster

  def runtime_display
    parts = []
    parts << [runtime["hours"], 'hour'.pluralize(runtime["hours"].to_i)].join(' ') unless runtime["hours"].to_i.zero?
    parts << [runtime["minutes"], 'minute'.pluralize(runtime["minutes"].to_i)].join(' ') unless runtime["minutes"].to_i.zero?
    parts << (runtime["intermission"] ? 'with intermission' : 'without intermission')
    parts.join(' ')
  end

end
