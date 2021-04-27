class ForecastFacade
  def self.get_forecast(city)
    lat_long = MapquestService.convert_city_to_lat_long(city)
    weather_data = OpenWeatherService.get_weather(lat_long[:lat], lat_long[:lng])
    current_weather = CurrentWeather.new(weather_data[:current])
    hourly_weather = weather_data[:hourly][0..7].map do |hourly_data|
      HourlyWeather.new(hourly_data)
    end
    daily_weather = weather_data[:daily][0..4].map do |daily_data|
      DailyWeather.new(daily_data)
    end
    Forecast.new(current_weather, daily_weather, hourly_weather)
  end
end
