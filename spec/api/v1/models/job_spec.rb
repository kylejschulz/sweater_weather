require 'rails_helper'

RSpec.describe Job, type: :model do
  describe "it can have attributes" do
    it "has attributes" do
      ua_id = TeleportService.get_ua_id('denver')
      all_salary_data =TeleportService.get_salary_info(ua_id)
      job_data = all_salary_data[:salaries][0]
      job_object = Job.new(job_data)

      expect(job_object).to be_an(Job)
      expect(job_object.title).to eq("Account Manager")
      expect(job_object.min).to eq("$52755.55")
      expect(job_object.max).to eq("$82696.16")
    end
  end
end
