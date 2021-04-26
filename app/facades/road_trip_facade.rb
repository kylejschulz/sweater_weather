class RoadTripFacade
  def self.get_info(start, end)
    routing_data = DirectionService.get_routing_data(start, end)
    lat_lng = GeocodeService.convert_city_to_lat_long(end)
    weather_at_arrival = OpenWeatherService.weather_at_arrival(lat_lng[:lat], lat_lng[:lng], routing_data[:eta])
    RoadTrip.new(routing_data, weather_at_arrival)
  end
end
