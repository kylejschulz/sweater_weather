class OpenWeatherService
  def self.get_weather(lat, lon)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall") do |f|
      f.params["appid"] = ENV["open_weather_api_key"]
      f.params['lat'] = lat
      f.params['lon'] = lon
      f.params['exclude'] = 'minutely'
      f.params['units'] = 'imperial'
    end
    parsed = parse(response)
  end

  private

  # def self.connection
  #   conn = Faraday.new(url: 'http://www.mapquestapi.com')
  # end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
