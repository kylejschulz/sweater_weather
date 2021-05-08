require "rails_helper"

RSpec.describe CurrentWeather, type: :model do
  describe "it can have attributes" do
    it "has attributes", :vcr do
      weather_data = OpenWeatherService.get_weather(39.738453, -104.984853)
      current_weather = CurrentWeather.new(weather_data[:current])

      expect(current_weather).to be_a(CurrentWeather)
      expect(current_weather.datetime).to eq("2021-04-28 03:42:49")
      expect(current_weather.sunrise).to eq("12:05")
      expect(current_weather.sunset).to eq("01:49")
      expect(current_weather.temperature).to eq(40.96)
      expect(current_weather.feels_like).to eq(33.53)
      expect(current_weather.humidity).to eq(88)
      expect(current_weather.uvi).to eq(0)
      expect(current_weather.visibility).to eq(182)
      expect(current_weather.conditions).to eq("overcast clouds")
      expect(current_weather.icon).to eq("04n")
    end
  end
end
