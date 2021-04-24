require 'rails_helper'

RSpec.describe "When i make a forecast request" do
  describe "it can return me " do
    it "can return me ", :vcr do
      get '/api/v1/forecast?location=denver,co'
      expect(response).to be_successful

      response = parse(@response)
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to be_nil
      expect(response[:data][:type]).to eq('forecast')
      expect(response[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      expect(response[:data][:attributes][:current_weather].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(response[:data][:attributes][:daily_weather].first.keys).to eq([:datetime, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      expect(response[:data][:attributes][:hourly_weather].first.keys).to eq([:time, :temperature, :conditions, :icon])
    end
  end
end
