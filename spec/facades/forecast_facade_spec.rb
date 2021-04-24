require 'rails_helper'

RSpec.describe ForecastFacade, model: :type do
  describe "class methods" do
    it "#get_forecast", :vcr do
      response = ForecastFacade.get_forecast('denver,co')
      require "pry"; binding.pry
      expect(response.first[:locations].first.length).to eq(22)
      expect(response.first[:locations].first.class).to be_an(Array)
      expect(response.first[:locations].first[:LatLng]).to eq({:lat=>39.738453, :lng=>-104.984853})
      expect(response.first[:locations].first[:LatLng]).to be_a(Hash)
    end
  end
end
