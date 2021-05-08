require 'rails_helper'

RSpec.describe "Roadtrip request" do
  before :each do
    @user = User.create!(email: 'kyle@example.com', password: 'password')
  end
  describe "happy path" do
    it "returns all the appropriate data", :vcr do
      @user_2 = User.create!(email: 'kyle_s@example.com', password: 'password')

      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { 'origin': 'Denver,CO', 'destination': 'Boulder,CO', 'api_key': @user_2.api_key }
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
      expect(response[:data][:attributes][:travel_time]).to eq('41 minutes')
      expect(response[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      expect(response[:data][:attributes][:weather_at_eta][:temperature]).to eq(45.73)
      expect(response[:data][:attributes][:weather_at_eta][:conditions]).to eq("overcast clouds")
    end
  end

  describe "sad paths" do
    it "returns 422 when given wrong api_key", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { 'origin': 'Denver,CO', 'destination': 'boulder,co', 'api_key': "1235sbddbf" }
      post '/api/v1/road_trip', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("invalid credentials")
      expect(@response.status).to eq(422)
    end

    it "returns 422 when given empty string", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { 'origin': 'Denver,CO', 'destination': '', 'api_key': @user.api_key }
      post '/api/v1/road_trip', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("please enter valid destination and origin")
      expect(@response.status).to eq(422)
    end

    it "returns 422 when given no destination", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { 'origin': 'Denver,CO', 'api_key': @user.api_key }
      post '/api/v1/road_trip', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("please enter valid destination and origin")
      expect(@response.status).to eq(422)
    end

    it "returns 422 when given integers", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { 'origin': 'Denver,CO', 'destination': '3345', 'api_key': @user.api_key }
      post '/api/v1/road_trip', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("please enter valid destination and origin")
      expect(@response.status).to eq(422)
    end

    # xit "returns 422 when given jumbled string", :vcr do
    #   headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
    #   params = { 'origin': 'Denver,CO', 'destination': 'ljhfasdljhdsf', 'api_key': @user.api_key }
    #   post '/api/v1/road_trip', :params => params.to_json, :headers => headers
    #
    #   expect(@response).to_not be_successful
    #   expect(@response.body).to eq("please enter valid destination and origin")
    #   expect(@response.status).to eq(422)
    # end
  end
end
