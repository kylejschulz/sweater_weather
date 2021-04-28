require "rails_helper"

RSpec.describe DailyWeather, type: :model do
  describe "it can have attributes" do
    it "has attributes", :vcr do
      weather_data = OpenWeatherService.get_weather(39.738453, -104.984853)[:daily].first
      daily_weather = DailyWeather.new(weather_data)

      expect(daily_weather).to be_a(DailyWeather)
      expect(daily_weather.datetime).to eq("2021-04-27 14:00:00")
      expect(daily_weather.sunrise).to eq("08:05")
      expect(daily_weather.sunset).to eq("21:49")
      expect(daily_weather.max_temp).to eq(59.7)
      expect(daily_weather.min_temp).to eq(40.77)
      expect(daily_weather.conditions).to eq("moderate rain")
      expect(daily_weather.icon).to eq("10d")
    end
  end
end


# 1619287200
# Time.at(1619287200).to_s(:date)
