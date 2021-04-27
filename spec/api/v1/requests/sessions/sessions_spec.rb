require 'rails_helper'

RSpec.describe "When i make a sessions request" do
  before :each do
    @user = User.create!(email: 'kyle@example.com', password: 'password')
  end
  describe "it can return happy paths" do
    it "returns all the appropriate data", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password" }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers
      require "pry"; binding.pry
      response = parse(@response)
      expect(response).to be_successful
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to eq(@user.id)
      expect(response[:data][:type]).to eq('users')
      expect(response[:data][:attributes].keys).to eq([:email, :api_key])
      expect(response[:data][:attributes][:email]).to eq("kyle@example.com")
      expect(response[:data][:attributes][:api_key]).to eq(@user.api_key)
    end
  end
  describe "it can return sad paths" do
    xit "returns 404 when given invalid email", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { "email": "kyle_1@example.com", "password": "password" }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(response).to be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end

    xit "returns 404 when given incorrect password", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   @user.email, "password": "password_1" }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(response).to be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end

    xit "returns 404 when given empty string password", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   @user.email, "password": "" }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(response).to be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end

    xit "returns 404 when given integer password", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   @user.email, "password": 12345 }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(response).to be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end

    xit "returns 404 when given no body at all", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post '/api/v1/sessions', :headers => headers
      response = parse(@response)

      expect(response).to be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end
  end
end
