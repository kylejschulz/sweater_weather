class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: road_trip_params[:api_key])
    if user
      if road_trip_params[:origin].blank? || road_trip_params[:origin].to_i != 0 || road_trip_params[:destination].blank? || road_trip_params[:destination].to_i != 0
        render json: "please enter valid destination and origin" , status: 422
      else
        roadtrip = RoadtripFacade.get_info(road_trip_params[:origin], road_trip_params[:destination])
        render json: RoadtripSerializer.new(roadtrip), status: 200
        sleep 1
      end
    else
      render json: "invalid credentials" , status: 422
      sleep 1
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end

end
