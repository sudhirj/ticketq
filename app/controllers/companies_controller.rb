# frozen_string_literal: true

class CompaniesController < ApplicationController
  def show
    @company = Company.find_by! slug: params[:company_slug]
    @performances = Performance.includes(%i[show venue]).joins(show: [:company]).where(shows: { company: @company }).to_a
    @performance_groups = @performances.group_by { |p| OpenStruct.new(show: p.show, venue:  p.venue) }
  end
end
