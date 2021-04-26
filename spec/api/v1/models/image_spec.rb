require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe "it can have attributes" do
    it "has attributes", :vcr do
      photo_data = BackgroundPhotoFacade.get_photo("denver,co")
      photo_object = Image.new(photo_data)

      expect().to be_a(Hash)
      expect(photo_object).to be_an(Image)
      expect(photo_object.time).to eq()
      expect(photo_object.temperature).to eq()
      expect(photo_object.conditions).to eq()
      expect(photo_object.icon).to eq()
    end
  end
end
