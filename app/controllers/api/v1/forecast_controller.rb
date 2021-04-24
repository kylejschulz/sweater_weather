class ForecastController < ApplicationController
  def index
    forecast = ForestFacade.get_forecast(forecast_params[:location])
    require "pry"; binding.pry
  end

  private 

  def forecast_params
    params.permit(:location)
  end
end
