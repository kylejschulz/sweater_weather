class BackgroundPhotoService
  def self.get_photo_url(city)
    response = Faraday.get("https://www.flickr.com/services/rest") do |f|
      f.params['method'] = 'flickr.photos.search'
      f.params["api_key"] = ENV["flickr_api_key"]
      f.params['text'] = city
      f.params['per_page'] = 1
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
    end
    parsed = parse(response)
    if  parsed[:stat] == 'fail' || parsed[:photos][:photo].empty?
      return "no photo available"
    else
      photo_id = parsed[:photos][:photo].first[:id].to_i
      get_photo_info(photo_id)[:photo][:urls][:url].first[:_content]
    end
  end

  def self.get_photo_info(photo_id)
    response = Faraday.get("https://www.flickr.com/services/rest") do |f|
      f.params["api_key"] = ENV["flickr_api_key"]
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
