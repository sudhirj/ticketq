class PerformancesController < ApplicationController
  def show
    @company = Company.find_by! slug: params[:company_slug]
    @show = @company.shows.find_by! slug: params[:show_slug]
    @performance = @show.performances.includes(:denominations, :venue).find_by! showtime: DateTime.parse(params[:datetime]).beginning_of_minute
    @denom_to_push = @performance.denominations.sort_by(&:price).last
  end
end
