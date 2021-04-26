require 'rails_helper'

RSpec.describe Salaries, type: :model do
  describe "it can have attributes" do
    it "has attributes" do
      weather_data = {:lat=>39.7385,
                     :current=>
                      {:dt=>1619456162,
                       :sunrise=>1619438778,
                       :sunset=>1619488125,
                       :temp=>71.02,
                       :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}]},
      ua_id = TeleportService.get_ua_id('denver')
      require "pry"; binding.pry
      all_salary_data =TeleportService.get_salary_info(ua_id)
      salary_data = all_salary_data[:salaries]
      specific_salary_data = []
       salary_data.each do |position|
         if ['Data Analyst', 'Data Scientist', 'Mobile Developer', 'QA Engineer', 'Software Engineer', 'Systems Administrator', 'Web Developer'].include?(position[:job][:title])
           specific_salary_data << position
         end
      end
      jobs = specific_salary_data.map do |data|
        Job.new(data)
      end
      salaries = Salaries.new("denver", weather_data, jobs)

      expect(salaries).to be_a(Salaries)
      expect(salaries.destination).to eq("denver")
      expect(salaries.id).to be_nil
      expect(salaries.forecast).to eq({:summary=>"scattered clouds", :temperature=>70.97})
      expect(salaries.salaries.first.title).to eq("Data Analyst")
      expect(salaries.salaries.first.min).to eq("$42878.34")
      expect(salaries.salaries.first.max).to eq("$62106.69")
      expect(salaries.salaries.count).to eq(7)
    end
  end
end
