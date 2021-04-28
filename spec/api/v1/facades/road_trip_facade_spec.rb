require 'rails_helper'

RSpec.describe RoadtripFacade, model: :type do
  describe "class methods" do
    it "#get_info happy path", :vcr do
      roadtrip = RoadtripFacade.get_info('denver,co', 'boulder,co')

      expect(roadtrip).to be_a(Roadtrip)
      expect(roadtrip.id).to be_nil
      expect(roadtrip.start_city).to eq('denver,co')
      expect(roadtrip.end_city).to eq('boulder,co')
      expect(roadtrip.travel_time).to eq('38 minutes')
      expect(roadtrip.weather_at_eta.keys).to eq([:temperature, :conditions])
    end

    it "#time_at_arrival", :vcr do
      time_at_arrival = RoadtripFacade.time_at_arrival(23454)

      expect(time_at_arrival).to eq(6)
    end
    
    it "#time_at_arrival", :vcr do
      time_at_arrival = RoadtripFacade.time_at_arrival(2345466)

      expect(time_at_arrival).to eq(47)
    end
  end

  describe "class methods sad path" do
    it "it can accept jumbled letters", :vcr do
      roadtrip = RoadtripFacade.get_info("ajlkhafds", 'denver,co')

      expect(roadtrip).to be_a(Roadtrip)
    end
  end
end
