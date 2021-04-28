require 'rails_helper'

RSpec.describe User, model: :type do
  describe "validations" do
    # xit { should validate_presence_of(:email) }
    # xit { should validate_presence_of(:password) }
    # xit { should have_secure_password }

  end
  describe "class methods" do
    it "#get_forecast", :vcr do
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
end
