class Api::V1::BackgroundsController < ApplicationController
  def index
    require "pry"; binding.pry
    image = BackgroundPhotoService.get_photo(photo_params[:location])
  end

  private

  def photo_params
    params.permit(:location)
  end
end
