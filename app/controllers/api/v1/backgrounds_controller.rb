class Api::V1::BackgroundsController < ApplicationController
  def index
    if photo_params[:location].blank? || photo_params[:location].to_i != 0
      render json: "please enter a valid city", status: 422
    else
      image = BackgroundPhotoFacade.get_photo(photo_params[:location])
      if image.image_url == "no photo available"
        render json: "photo not found", status: 422
      else
      render json: ImageSerializer.new(image), status: 200
      end
    end

  end

  private

  def photo_params
    params.permit(:location)
  end
end
