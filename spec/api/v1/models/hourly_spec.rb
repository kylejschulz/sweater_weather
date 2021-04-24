require 'rails_helper'

RSpec.describe Hourly, model: :type do
  describe "it can have attributes" do
    it "has attributes" do
      data = {}
      hourly = Hourly.new(data)

      expect(hourly.time).to eq()
      expect(hourly.temperature).to eq()
      expect(hourly.condtions).to eq()
      expect(hourly.icon).to eq(19)
    end
  end
end
