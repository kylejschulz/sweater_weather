class MapquestService
  def self.convert_city_to_lat_long(city)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address") do |f|
      f.params["key"] = ENV["mapquest_api_key"]
      f.params['location'] = city
    end
    parse(response)[:results].first[:locations].first[:latLng]
  end

  def self.travel_time(start, destination)
    response = Faraday.get("https://www.mapquestapi.com/directions/v2/route") do |f|
      f.params["key"] = ENV["mapquest_api_key"]
      f.params['from'] = start
      f.params['to'] = destination
      f.params['outFormat'] = 'json'
      f.params['ambiguities'] = 'ignore'
      f.params['routeType'] = 'fastest'
      f.params['unit'] = 'm'
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
