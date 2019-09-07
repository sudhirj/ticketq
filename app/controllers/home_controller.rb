class HomeController < ApplicationController
  def index
    @performances = Performance.active.includes(%i[show venue]).joins(show: [:company]).to_a
    @performance_groups = @performances.group_by { |p| OpenStruct.new(show: p.show, venue:  p.venue) }
  end
end
