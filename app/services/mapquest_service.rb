class MapquestService
  def self.convert_city_to_lat_long(city)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address") do |f|
      f.params["key"] = "9DNRSfALshlNLG8C1tdJE9CW8VZAiRqe"
      f.params['location'] = city
    end
    parse(response)[:results].first[:locations].first[:latLng]
  end

  def self.travel_time(start, destination)
    response = Faraday.get("https://www.mapquestapi.com/directions/v2/route") do |f|
      f.params["key"] = "9DNRSfALshlNLG8C1tdJE9CW8VZAiRqe"
      f.params['from'] = start
      f.params['to'] = destination
      f.params['outFormat'] = 'json'
      f.params['ambiguities'] = 'ignore'
      f.params['routeType'] = 'fastest'
      f.params['doReverseGeocode'] = false
      f.params['EnhancedNarrative'] = false
      f.params['avoidTimedConditions'] = false
    end
    parse(response)
    require "pry"; binding.pry
  end

  private

  # def self.connection
  #   conn = Faraday.new(url: 'http://www.mapquestapi.com')
  # end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
