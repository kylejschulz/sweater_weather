require 'rails_helper'

RSpec.describe TeleportService, type: :model do
  describe "class methods" do
    it "#get_ua_id" do
      response = TeleportService.get_ua_id('denver')

      expect(response).to be_a(String)
      expect(response).to eq("9xj65")
    end

    it "#get_salary_info" do

      response = TeleportService.get_salary_info("9xj65")

      expect(response[:salaries]).to be_an(Array)
      expect(response[:salaries].count).to eq(52)
      expect(response[:salaries].first.keys).to eq([:job, :salary_percentiles])
      expect(response[:salaries].first[:job].keys).to eq([:id, :title])
      expect(response[:salaries].first[:salary_percentiles].keys).to eq([:percentile_25, :percentile_50, :percentile_75])
    end
  end
end
