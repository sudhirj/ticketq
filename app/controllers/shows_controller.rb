class ShowsController < ApplicationController
  def show
    @company = Company.find_by! slug: params[:company_slug]
    @show = @company.shows.find_by! slug: params[:show_slug]
    @performances = Performance.includes(:venue).where(show: @show).to_a
    @venue_groups = @performances.group_by(&:venue)
  end
end
