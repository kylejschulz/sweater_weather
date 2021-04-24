require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe "it can have attributes" do
    it "has attributes", :vcr do
      forecast = ForecastFacade.get_forecast("denver,co")

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
end
