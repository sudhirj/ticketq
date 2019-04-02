class PerformancesController < ApplicationController
  def show
    @company = Company.find_by! slug: params[:company_slug]
    @show = @company.shows.find_by! slug: params[:show_slug]
    @performance = @show.performances.find_by! showtime: DateTime.parse(params[:datetime]).beginning_of_minute
  end
end
