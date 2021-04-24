class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  has_many :daily
  has_many :hourly_weather
  attributes :current_weather
end
