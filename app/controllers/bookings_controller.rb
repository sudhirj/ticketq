class BookingsController < ApplicationController
  def create
    render json: params
  end
end
