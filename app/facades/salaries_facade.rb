class SalariesFacade
  def self.make_salary_object(location)
    lat_long = GeocodeService.convert_city_to_lat_long(location)
    weather_data = OpenWeatherService.get_weather(lat_long[:lat], lat_long[:lng])
    ua_id = TeleportService.get_ua_id(location)
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
    Salaries.new(location, weather_data, jobs)
  end
end
