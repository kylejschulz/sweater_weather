class HourlyWeather
  attr_reader :time,
              :termperature,
              :conditions,
              :icon
  def initialize(data)
    @time = data[:dt]
    @temperature = data[:temp]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
