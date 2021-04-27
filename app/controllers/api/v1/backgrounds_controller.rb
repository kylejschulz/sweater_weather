class Api::V1::BackgroundsController < ApplicationController
  def index
    image = BackgroundPhotoService.get_photo(photo_params[:location])
    require "pry"; binding.pry
    render json: ImageSerializer.new(image), status: 200

  end

  private

  def photo_params
    params.permit(:location)
  end
end
