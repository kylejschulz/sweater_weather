require 'rails_helper'

RSpec.describe HourlyWeather, type: :model do
  describe "it can have attributes" do
    it "has attributes", :vcr do
      weather_data = OpenWeatherService.get_weather(39.738453, -104.984853)[:hourly].first
      hourly_weather = HourlyWeather.new(weather_data)

      expect(weather_data).to be_a(Hash)
      expect(hourly_weather).to be_a(HourlyWeather)
      expect(hourly_weather.time).to eq("2021-04-27 23:00:00")
      expect(hourly_weather.temperature).to eq(41.72)
      expect(hourly_weather.conditions).to eq("moderate rain")
      expect(hourly_weather.icon).to eq("10n")
    end
  end
end
