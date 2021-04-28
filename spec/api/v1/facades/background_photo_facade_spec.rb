require 'rails_helper'

RSpec.describe BackgroundPhotoFacade, model: :type do
  describe "class methods" do
    it "#get_photo", :vcr do
      image = BackgroundPhotoFacade.get_photo('denver, co')

      expect(image).to be_an(Image)
      expect(image.id).to be_nil
      expect(image.image_url).to be_a(String)
      expect(image.image_url).to eq("https://www.flickr.com/photos/124159081@N07/51142415522/")
    end
  end
  describe "class methods sad path" do
    it "#get_photo can accept jumbled characters", :vcr do
      image = BackgroundPhotoFacade.get_photo('dsfgsdgsdfg')
      expect(image.image_url).to eq("no photo available")
    end

    it "#get_photo can accept an empty string", :vcr do
      image = BackgroundPhotoFacade.get_photo('')
      expect(image.image_url).to eq('no photo available')
    end

    it "#get_photo can accept an int", :vcr do
      image = BackgroundPhotoFacade.get_photo(1234)

      expect(image.image_url).to eq("https://www.flickr.com/photos/192840124@N05/51143524561/")
    end
  end
end
