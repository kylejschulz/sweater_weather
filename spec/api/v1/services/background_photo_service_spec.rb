require 'rails_helper'

RSpec.describe BackgroundPhotoService, type: :model do
  describe "class methods" do
    it "#get_photo_url", :vcr do
      response = BackgroundPhotoService.get_photo_url('denver, co')
      expect(response).to be_a(String)
    end

    it "#get_photo_info", :vcr do
      response = BackgroundPhotoService.get_photo_info(51123309253)
      expect(response[:photo][:id].to_i).to eq(51123309253)
      expect(response).to be_a(Hash)
      expect(response[:photo]).to be_a(Hash)
      expect(response[:photo][:urls]).to be_a(Hash)
      expect(response[:photo][:urls][:url]).to be_a(Array)
      expect(response[:photo][:urls][:url].first).to be_a(Hash)
      expect(response[:photo][:urls][:url].first[:_content]).to be_a(String)
    end
  end

  describe "class methods sad path" do
    it "#get_photo_id can handle a jumbled string", :vcr do
      response = BackgroundPhotoService.get_photo_url('sddkjlhsdflkjhdfsalkhjf')

      expect(response).to eq("no photo available")
    end

    it "#get_photo_info can handle a jumbled string", :vcr do
      response = BackgroundPhotoService.get_photo_info("asdgjhsdfajhd")

      expect(response[:message]).to eq("Photo not found")
    end

    it "#get_photo_info can handle a negative number", :vcr do
      response = BackgroundPhotoService.get_photo_info(-123)

      expect(response[:message]).to eq("Photo \"-123\" not found (invalid ID)")
      expect(response[:stat]).to eq('fail')
    end
  end
end
