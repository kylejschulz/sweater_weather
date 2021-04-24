class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  # has_many :daily_weather
  # has_many :hourly_weather
  attributes :current_weather, :daily_weather, :hourly_weather
end
