require 'rails_helper'

RSpec.describe Image, type: :model do
  describe "it can have attributes" do
    it "has attributes", :vcr do
      photo_data = 'www.photo.com'
      photo_object = Image.new(photo_data)
      expect(photo_object).to be_an(Image)
      expect(photo_object.image_url).to eq('www.photo.com')
    end
  end
end
