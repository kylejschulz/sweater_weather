class Salaries
  attr_reader :id,
              :destination,
              :forecast,
              :salaries
  def initialize(destination, weather_data, jobs)
    @id = nil
    @destination = destination
    @forecast = {
                  summary: weather_data[:current][:weather].first[:description],
                  temperature: weather_data[:current][:temp]
                }
    @salaries = jobs
  end
end
