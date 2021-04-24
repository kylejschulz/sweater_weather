require "rails_helper"

RSpec.describe DailyWeather, type: :model do
  describe "it can have attributes" do
    it "has attributes", :vcr do
      weather_data = OpenWeatherService.get_weather(39.738453, -104.984853)[:daily].first
      daily_weather = DailyWeather.new(weather_data)

      expect(daily_weather).to be_a(DailyWeather)
      expect(daily_weather.datetime).to eq("2021-04-24 14:00:00")
      expect(daily_weather.sunrise).to eq("08:08")
      expect(daily_weather.sunset).to eq("21:46")
      expect(daily_weather.max_temp).to eq(66.07)
      expect(daily_weather.min_temp).to eq(38.21)
      expect(daily_weather.conditions).to eq("scattered clouds")
      expect(daily_weather.icon).to eq("03d")
    end
  end
end


# 1619287200
# Time.at(1619287200).to_s(:date)
