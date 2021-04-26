class Api::V1::SalariesController < ApplicationController
  def index
    # lat_long = GeocodeService.convert_city_to_lat_long(salary_params[:location])
    # weather_data = OpenWeatherService.get_weather(lat_long[:lat], lat_long[:lng])
    # ua_id = TeleportService.get_ua_id(salary_params[:location])
    # all_salary_data =TeleportService.get_salary_info(ua_id)
    # salary_data = all_salary_data[:salaries]
    # specific_salary_data = []
    #  salary_data.each do |position|
    #    if ['Data Analyst', 'Data Scientist', 'Mobile Developer', 'QA Engineer', 'Software Engineer', 'Systems Administrator', 'Web Developer'].include?(position[:job][:title])
    #      specific_salary_data << position
    #    end
    # end
    # jobs = specific_salary_data.map do |data|
    #   Job.new(data)
    # end
    # salaries = Salaries.new(salary_params[:location], weather_data, jobs)
    salaries_object = SalariesFacade.make_salary_object(salary_params[:location])
    render json: SalariesSerializer.new(salaries_object), status: 200
  end


  private

  def salary_params
    params.permit(:location)
  end
end


# bundle exec rspec spec/api/v1/requests/salaries
