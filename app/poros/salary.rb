class Salaries
  attr_reader :title,
              :min,
              :max
  def initialize(destination, weather_data, jobs)
    @destination = destination
    @forecast = weather_data
    @salaries = jobs
  end
end
