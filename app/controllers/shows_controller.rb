class ShowsController < ApplicationController
  def show
    @company = Company.find_by! slug: params[:company_slug]
    @show = @company.shows.find_by! slug: params[:show_slug]
    @performances = Performance.includes(:venue).where(show: @show)
    @performances = @performances.where(venue: Venue.find_by!(slug: params[:venue_slug])) if params[:venue_slug].present?
    @performances = @performances.where('showtime > ?', DateTime.current - 2.hours)
    @performances = @performances.to_a
    @venue_groups = @performances.group_by(&:venue)
  end
end
