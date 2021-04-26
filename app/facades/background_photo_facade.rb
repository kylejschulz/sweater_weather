class BackgroundPhotoFacade
  def self.get_photo(city)
    photo_id = BackgroundPhotoService.get_photo_id(city)
    photo_data = BackgroundPhotoService.get_photo_info(photo_id)
    Image.new(photo_data)
  end
end
