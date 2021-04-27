require 'rails_helper'

RSpec.describe "When i make a new user request" do
  describe "it can return happy paths" do
    it "returns all the appropriate data when i input the correct data", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers
      require "pry"; binding.pry
      response = parse(@response)
      expect(response).to be_successful
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to_not be_nil
      expect(response[:data][:type]).to eq('users')
      expect(response[:data][:attributes].keys).to eq([:email, :api_key])
      expect(response[:data][:attributes][:email]).to eq("kyle@example.com")
      expect(response[:data][:attributes][:api_key].count).to eq(20)
      expect(response[:data][:attributes][:api_key]).to be_a(String)
    end
  end
  describe "it can return sad paths" do
    xit "returns 404 when given already used email", :vcr do
      @user = User.create!(email: 'kyle@example.com', password: 'password')

      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(response).to_not be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end

    xit "returns 404 when given passwords don't match", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password_1" }
      post '/api/v1/users', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(response).to_not be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end

    xit "returns 404 when given invalid email", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(response).to_not be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end

    xit "returns 404 when given no email", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers
      response = parse(@response)

      expect(response).to_not be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end

    xit "returns 404 when given no body at all", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post '/api/v1/users', :headers => headers
      response = parse(@response)

      expect(response).to_not be_successful
      require "pry"; binding.pry
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
    end
  end
end
