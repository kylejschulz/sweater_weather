require 'rails_helper'

RSpec.describe OpenWeatherService, model: :type do
  describe "class methods" do
    it "#get_weather", :vcr do
      lat = 39.738453
      lon = -104.984853
      response = OpenWeatherService.get_weather(lat, lon)
      expect(response[:current].keys).to eq([:dt, :sunrise, :sunset, :temp, :feels_like, :pressure, :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, :wind_gust, :weather])
      expect(response[:hourly].first.keys).to eq([:dt, :temp, :feels_like, :pressure, :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, :wind_gust, :weather, :pop])
      expect(response[:daily].first.keys).to eq([:dt, :sunrise, :sunset, :moonrise, :moonset, :moon_phase, :temp, :feels_like, :pressure, :humidity, :dew_point, :wind_speed, :wind_deg, :wind_gust, :weather, :clouds, :pop, :rain, :uvi])
      expect(response[:daily].first.count).to eq(19)
      expect(response[:daily].first).to be_a(Hash)
    end
  end
end
