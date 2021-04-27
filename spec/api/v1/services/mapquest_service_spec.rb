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
end
