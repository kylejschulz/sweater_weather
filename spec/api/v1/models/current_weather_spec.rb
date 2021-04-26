require "rails_helper"

RSpec.describe CurrentWeather, type: :model do
  describe "it can have attributes" do
    it "has attributes", :vcr do
      weather_data = OpenWeatherService.get_weather(39.738453, -104.984853)
      current_weather = CurrentWeather.new(weather_data[:current])

      expect(current_weather).to be_a(CurrentWeather)
      expect(current_weather.datetime).to eq("2021-04-24 13:54:32")
      expect(current_weather.sunrise).to eq("08:08")
      expect(current_weather.sunset).to eq("21:46")
      expect(current_weather.temperature).to eq(55.15)
      expect(current_weather.feels_like).to eq(52.95)
      expect(current_weather.humidity).to eq(55)
      expect(current_weather.uvi).to eq(6.7)
      expect(current_weather.visibility).to eq(10000)
      expect(current_weather.conditions).to eq("scattered clouds")
      expect(current_weather.icon).to eq("03d")
    end
  end
end
