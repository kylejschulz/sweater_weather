require 'rails_helper'

RSpec.describe "Backgrounds request" do
  describe "it can return happy paths" do
    it "returns all the appropriate data", :vcr do
      get '/api/v1/backgrounds?location=denver,co'
      expect(@response).to be_successful
      response = parse(@response)

      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to be_nil
      expect(response[:data][:type]).to eq('image')
      expect(response[:data][:attributes].keys).to eq([:image_url])
      expect(response[:data][:attributes][:image_url]).to eq('https://www.flickr.com/photos/mudsharkalex/51142231625/')
    end
  end
  describe "it can return sad paths" do
    it "returns 42 when given empty string", :vcr do
      get '/api/v1/backgrounds?location= '

      expect(@response).to_not be_successful
      expect(@response.status).to eq(422)
      expect(@response.body).to eq("please enter a valid city")
    end

    it "returns 42 when given integers", :vcr do
      get '/api/v1/backgrounds?location=12345'

      expect(@response).to_not be_successful
      expect(@response.status).to eq(422)
      expect(@response.body).to eq("please enter a valid city")
    end

    it "returns 42 when given jumbled letters", :vcr do
      get '/api/v1/backgrounds?location=akjfljhfs'

      expect(@response).to_not be_successful
      expect(@response.status).to eq(422)
      expect(@response.body).to eq("photo not found")
    end
  end
end
