require 'rails_helper'

RSpec.describe SalariesFacade, model: :type do
  describe "class methods" do
    it "#make_salary_object" do
      salaries = SalariesFacade.make_salary_object('denver')

      expect(salaries).to be_a(Salaries)
      expect(salaries.id).to be_nil
      expect(salaries.forecast).to eq({:summary=>"scattered clouds", :temperature=>71.65})
      expect(salaries.destination).to eq('denver')

      expect(salaries.salaries.count).to eq(7)
      expect(salaries.salaries.first.title).to eq("Data Analyst")
      expect(salaries.salaries.first.max).to eq("$62106.69")
      expect(salaries.salaries.first.min).to eq("$42878.34")
    end
  end
end
