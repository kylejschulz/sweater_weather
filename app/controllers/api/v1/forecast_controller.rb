class Api::V1::ForecastController < ApplicationController
  def index
    if forecast_params[:location].blank? || forecast_params[:location].to_i != 0
      render json: "please enter a valid city", status: 422
    else
      forecast = ForecastFacade.get_forecast(forecast_params[:location])
      render json: ForecastSerializer.new(forecast)
    end
  end

  private

  def forecast_params
    params.permit(:location)
  end
end
