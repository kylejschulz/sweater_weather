require 'rails_helper'

RSpec.describe MapquestService, type: :model do
  describe "class methods" do
    it "#convert_city_to_lat_long", :vcr do
      response = MapquestService.convert_city_to_lat_long('denver,co')

      expect(response.keys).to eq([:lat, :lng])
      expect(response.values).to eq([39.738453, -104.984853])
      expect(response).to eq({:lat=>39.738453, :lng=>-104.984853})
      expect(response).to be_a(Hash)
    end
  end
  describe "class methods sad path" do
    it "it can accept jumbled letters", :vcr do
      response = MapquestService.convert_city_to_lat_long('sdfgsdgf')

      expect(response.keys).to eq([:lat, :lng])
      expect(response.values).to eq([39.390897, -99.066067])
      expect(response).to eq({:lat=>39.390897, :lng=>-99.066067})
      expect(response).to be_a(Hash)
    end
    it "it can acept integers", :vcr do
      response = MapquestService.convert_city_to_lat_long(1345)

      expect(response.keys).to eq([:lat, :lng])
      expect(response.values).to eq([42.717751, 23.287201])
      expect(response).to eq({:lat=>42.717751, :lng=>23.287201})
      expect(response).to be_a(Hash)
    end
  end
end
