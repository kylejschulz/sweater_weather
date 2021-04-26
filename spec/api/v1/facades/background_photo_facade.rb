require 'rails_helper'

RSpec.describe BackgroundPhotoFacade, model: :type do
  describe "class methods" do
    xit "#get_photo", :vcr do
      image = BackgroundPhotoFacade.get_photo('denver, co')
      expect(image).to be_an(Image)
      expect(image.id).to be_nil
      expect(image.image_url).to be_a("string")
    end
  end
  describe "class methods sad path" do
    xit "#get_photo can accept jumbled characters" do
      image = BackgroundPhotoFacade.get_photo('dsfgsdgsdfg')
      expect(image).to eq('?')
    end

    xit "#get_photo can accept an empty string" do
      image = BackgroundPhotoFacade.get_photo('')
      expect(image).to eq('?')
    end

    xit "#get_photo can accept an int" do
      image = BackgroundPhotoFacade.get_photo(1234)
      expect(image).to eq('?')
    end
  end
end
