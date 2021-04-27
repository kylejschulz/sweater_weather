require 'rails_helper'

RSpec.describe "When i make a road trip request" do
  before :each do
    @user = User.create!(email: 'kyle@example.com', password: 'password')
  end
  describe "it can return happy paths" do
    it "returns all the appropriate data", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { 'origin': 'Denver,CO', 'destination': 'Boulder,CO', 'api_key': @user.api_key }
      post '/api/v1/road_trip', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(@response).to be_successful
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to be_nil
      expect(response[:data][:type]).to eq('roadtrip')
      expect(response[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(response[:data][:attributes][:start_city]).to eq('Denver,CO')
      expect(response[:data][:attributes][:end_city]).to eq('Boulder,CO')
      expect(response[:data][:attributes][:travel_time]).to eq('39 minutes')
      expect(response[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      expect(response[:data][:attributes][:weather_at_eta][:temperature]).to eq(55.06)
      expect(response[:data][:attributes][:weather_at_eta][:conditions]).to eq('light rain')
    end
  end

  # bundle exec rspec spec/api/v1/requests/road_trips
  describe "it can return sad paths" do
    xit "returns 404 when given invalid city", :vcr do
      get '/api/v1/forecast?location= '
      expect(response).to be_successful
      require "pry"; binding.pry
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
