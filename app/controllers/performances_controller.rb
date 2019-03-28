class PerformancesController < ApplicationController
  def show
    @showtime = DateTime.parse(params[:datetime])
  end
end
