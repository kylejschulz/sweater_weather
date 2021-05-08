require 'rails_helper'

RSpec.describe "Forecast request" do
  describe "it can return happy paths" do
    it "returns all the appropriate data", :vcr do
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

  describe "it can return sad paths" do
    it "returns 422 when given an empty string", :vcr do
      get '/api/v1/forecast?location= '

      expect(@response).to_not be_successful
      expect(@response.status).to eq(422)
      expect(@response.body).to eq('please enter a valid city')
    end

    # xit "returns 422 when given jumbled letters", :vcr do
    #   get '/api/v1/forecast?location=dsfakjfds;kdfsljkf'
    #
    #   expect(@response).to_not be_successful
    #   expect(@response.status).to eq(422)
    #   expect(@response.body).to eq('please enter a valid city')
    # end

    it "returns 422 when given integers", :vcr do
      get '/api/v1/forecast?location=12457'

      expect(@response).to_not be_successful
      expect(@response.status).to eq(422)
      expect(@response.body).to eq('please enter a valid city')
    end
  end
end
