require 'rails_helper'

RSpec.describe "When i make a salary request" do
  describe "it can return happy paths" do
    it "returns all the appropriate data including, " do
      get '/api/v1/salaries?location=denver'
      expect(@response).to be_successful
      response = parse(@response)

      expect(response[:data].count).to eq(3)
      expect(response[:data].keys).to eq([:id, :type, :attributes])
      expect(response[:data][:id]).to be_nil
      expect(response[:data][:type]).to eq('salaries')
      expect(response[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
      expect(response[:data][:attributes][:destination]).to eq("denver")
      expect(response[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(response[:data][:attributes][:salaries]).to be_an(Array)
    end
  end

  describe "it can return sad paths" do
    it "returns all the appropriate data including, " do
      get '/api/v1/salaries?location=  '

      expect(@response).to_not be_successful
      expect(@response.body).to eq("please enter a valid city")
      expect(@response.status).to eq(422)
    end
  end
end

# bundle exec rspec spec/api/v1/requests/salaries
