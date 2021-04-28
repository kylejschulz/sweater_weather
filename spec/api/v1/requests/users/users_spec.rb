require 'rails_helper'

RSpec.describe "User request" do
  describe "happy paths" do
    it "returns all the appropriate data when i input the correct data", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers
      response = parse(@response)
      expect(@response).to be_successful
      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to_not be_nil
      expect(response[:data][:type]).to eq('users')
      expect(response[:data][:attributes].keys).to eq([:email, :api_key])
      expect(response[:data][:attributes][:email]).to eq("kyle@example.com")
      expect(response[:data][:attributes][:api_key].length).to eq(24)
      expect(response[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe "sad paths" do
    it "returns 404 when given already used email", :vcr do
      User.destroy_all
      @user = User.create!(email: 'kyle@example.com', password: 'password')

      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Email has already been taken")
      expect(@response.status).to eq(422)
    end

    it "returns 404 when given passwords don't match", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle@example.com", "password": "password", "password_confirmation": "password_1" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Password confirmation doesn't match Password and Password confirmation doesn't match Password")
      expect(@response.status).to eq(422)
    end

    it "returns 404 when given invalid email", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "kyle", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Email is invalid")
      expect(@response.status).to eq(422)
    end

    it "returns 404 when given no email", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      params = {   "email": "", "password": "password", "password_confirmation": "password" }
      post '/api/v1/users', :params => params.to_json, :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Email can't be blank and Email is invalid")
      expect(@response.status).to eq(422)
    end

    it "returns 404 when given no body at all", :vcr do
      headers = { "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post '/api/v1/users', :headers => headers

      expect(@response).to_not be_successful
      expect(@response.body).to eq("Password can't be blank, Password can't be blank, Password is too short (minimum is 6 characters), Email can't be blank, and Email is invalid")
      expect(@response.status).to eq(422)
    end
  end
end
