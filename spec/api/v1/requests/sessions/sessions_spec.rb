require 'rails_helper'

RSpec.describe "Sessions request" do
  before :each do
    User.destroy_all
    @user = User.create!(email: 'kyle@example.com', password: 'password')
  end
  describe "happy path" do
    it "returns all the appropriate data", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { email: "kyle@example.com", password: "password" }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers

      response = parse(@response)
      expect(@response).to be_successful
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to eq(@user.id.to_s)
      expect(response[:data][:type]).to eq('users')
      expect(response[:data][:attributes].keys).to eq([:email, :api_key])
      expect(response[:data][:attributes][:email]).to eq(@user.email)
      expect(response[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe "sad paths" do
    it "returns 404 when given invalid email", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = { "email": "kyle_1@example.com", "password": "password" }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("invalid credentials")
      expect(@response.status).to eq(422)
    end

    it "returns 404 when given incorrect password", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   email: @user.email, "password": "password_1" }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("invalid credentials")
      expect(@response.status).to eq(422)
    end

    it "returns 404 when given empty string password", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   email: @user.email, "password": "" }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("invalid credentials")
      expect(@response.status).to eq(422)
    end

    it "returns 404 when given integer password", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   email: @user.email, "password": 12345 }
      post '/api/v1/sessions', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("invalid credentials")
      expect(@response.status).to eq(422)
    end

    it "returns 404 when given no body at all", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post '/api/v1/sessions', :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("invalid credentials")
      expect(@response.status).to eq(422)
    end
  end
end
