class Api::V1::RoadTripController < ApplicationController
  def index
    require "pry"; binding.pry
    user = User.find_by(api_key: road_trip_params[:api_key])
    if user
      road_trip = RoadTrip.get_info(road_trip_params[:origin], road_trip_params[:destination])
      render json: RoadTripSerializer.new(road_trip), status: 200
      sleep 1
    else
      render json: "invalid credentials" , status: 422
      sleep 1
    end
  end

  private

  def raod_trip_params
    params.permit(:origin, :destination, :api_key)
  end

end
