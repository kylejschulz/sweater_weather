class ForecastFacade
  def self.get_forecast(city)
    lat_long = GeocodeService.convert_city_to_lat_long(city)
    weather_data = OpenWeatherService.get_weather(lat_long[:lat], lat_long[:lng])
    current_weather = Current.new(weather_data[:current])
    hourly_forecasts = weather_data[:hourly][0..7].map do |hourly_data|
      Hourly.new(hourly_data)
    end
    daily_forecasts = weather_data[:daily][0..4].map do |daily_data|
      Daily.new(daily_data)
    end
    require "pry"; binding.pry
  end
end
