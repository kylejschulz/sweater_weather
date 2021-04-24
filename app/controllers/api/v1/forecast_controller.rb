class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.get_forecast(forecast_params[:location])
    serialized = ForecastSerializer.new(forecast)
    render json: ForecastSerializer.new(forecast)
  end

  private

  def forecast_params
    params.permit(:location)
  end
end
