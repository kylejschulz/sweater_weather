require 'rails_helper'

RSpec.describe BackgroundPhotoService, type: :model do
  describe "class methods" do
    xit "#get_photo_id", :vcr do
      response = BackgroundPhotoService.get_photo_id('denver, co')

      expect(response).to be_an(Image)
      expect(response.id).to be_nil
      expect(response.image_url).to eq("https://www.flickr.com/photos/20tcb10/51123309253/")
    end

    xit "#get_photo_info", :vcr do
      response = BackgroundPhotoService.get_photo_info(51123309253)
      require "pry"; binding.pry
      expect(response).to eq(51123309253)
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
      response = BackgroundPhotoService.get_photo_id('sddkjlhsdflkjhdfsalkhjf')
      expect(response).to be_a(Hash)
    end

    it "#get_photo_id can handle a negative integer", :vcr do
      response = BackgroundPhotoService.get_photo_id(-20)
      expect(response).to be_a(Hash)
    end

    it "#get_photo_info can handle a jumbled string", :vcr do
      response = BackgroundPhotoService.get_photo_info("asdgjhsdfajhd")

      expect(response).to be_a(Hash)
      expect(response.keys).to eq([:stat, :code, :message])
    end

    it "#get_photo_info can handle a negative number", :vcr do
      response = BackgroundPhotoService.get_photo_info(-123)

      expect(response).to be_a(Hash)
      expect(response.keys).to eq([:stat, :code, :message])
    end
  end
end
