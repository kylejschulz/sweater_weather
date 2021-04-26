class Api::V1::SalariesController < ApplicationController
  def index
    lat_long = GeocodeService.convert_city_to_lat_long(salary_params[:location])
    weather_data = OpenWeatherService.get_weather(lat_long[:lat], lat_long[:lng])
    ua_id = TeleportService.get_ua_id(salary_params[:location])
    all_salary_data =TeleportService.get_salary_info(ua_id)
    require "pry"; binding.pry
    salary_data = all_salary_data[:_links][:salaries]
    specific_salary_data.map do |position|
      position[:job][:id].include(['Data Analyst', 'Data Scientist', 'Mobile Developer', 'QA Engineer', 'Software Engineer', 'Systems Administrator', 'Web Developer'])
    end
  end


  private

  def salary_params
    params.permit(:location)
  end
end
