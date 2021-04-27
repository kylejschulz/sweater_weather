class RoadtripFacade
  def self.get_info(start, destination)
    routing_data = MapquestService.travel_time(start, destination)
    route_time = routing_data[:route][:realTime]
    lat_lng = MapquestService.convert_city_to_lat_long(destination)
    data = {}
    data[:start_city] = start
    data[:end_city] = destination
    data[:travel_time] = route_time
    weather_at_destination = OpenWeatherService.get_weather(lat_lng[:lat], lat_lng[:lng])
    data[:weather_at_eta] = weather_at_destination[:hourly][time_at_arrival(route_time)]
    weather_at_arrival = weather_at_destination
    Roadtrip.new(data)
  end

  def self.time_at_arrival(route_time)
     if (route_time /3600.00).floor > 47
       47
     else
       (route_time /3600.00).floor
     end
  end

  def self.valid_route(start, destination)
  end
end
