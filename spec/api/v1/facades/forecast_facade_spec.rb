require 'rails_helper'

RSpec.describe ForecastFacade, model: :type do
  describe "class methods" do
    it "#get_forecast happy path", :vcr do
      forecast = ForecastFacade.get_forecast('denver,co')

      expect(forecast).to be_a(Forecast)
      expect(forecast.id).to be_nil
      expect(forecast.current_weather).to be_a(CurrentWeather)
      expect(forecast.hourly_weather).to be_an(Array)
      expect(forecast.hourly_weather.first).to be_an(HourlyWeather)
      expect(forecast.hourly_weather.count).to eq(8)
      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.daily_weather.first).to be_a(DailyWeather)
      expect(forecast.daily_weather.count).to eq(5)
    end
  end
  describe "class methods sad path" do
    it "it can accept integers", :vcr do
      forecast = ForecastFacade.get_forecast(12345)

      expect(forecast).to be_a(Forecast)
    end
    it "it can accept jumbled letters", :vcr do
      forecast = ForecastFacade.get_forecast("ajlkhafds")

      expect(forecast).to be_a(Forecast)
    end
    it "it can accept an empty string", :vcr do
      forecast = ForecastFacade.get_forecast(" ")

      expect(forecast).to be_a(Forecast)
    end
  end
end
