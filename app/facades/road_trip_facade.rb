class RoadTripFacade
  def self.get_info(start, destination)
    routing_data = DirectionService.get_routing_data(start, destination)
    lat_lng = MapquestService.convert_city_to_lat_long(destination)
    weather_at_arrival = OpenWeatherService.weather_at_arrival(lat_lng[:lat], lat_lng[:lng], routing_data[:eta])
    RoadTrip.new(routing_data, weather_at_arrival)
  end
end
