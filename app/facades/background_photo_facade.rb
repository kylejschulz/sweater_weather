class BackgroundPhotoFacade
  def self.get_photo(city)
    photo_data = BackgroundPhotoService.get_photo_url(city)
    Image.new(photo_data)
  end
end
