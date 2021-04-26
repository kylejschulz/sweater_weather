class BackgroundPhotoService
  def self.get_photo_id(city)
    response = Faraday.get("https://www.flickr.com/services/rest") do |f|
      f.params['method'] = 'flickr.photos.search'
      f.params["api_key"] = "a14ff48732412aa961d9b773ca494e7d"
      f.params['text'] = city
      f.params['per_page'] = 1
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
    end
    photo_id = parse(response)[:photos][:photo].first[:id].to_i
    get_photo_info(photo_id)
  end

  def self.get_photo_info(photo_id)
    response = Faraday.get("https://www.flickr.com/services/rest") do |f|
      f.params["api_key"] = "a14ff48732412aa961d9b773ca494e7d"
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
      f.params['method'] = 'flickr.photos.getinfo'
      f.params['photo_id'] = photo_id
    end
    parse(response)
  end

  private

  # def self.connection
  #   conn = Faraday.new(url: 'http://www.mapquestapi.com')
  # end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
