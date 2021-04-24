class DailyWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon
  def initialize(data)
    @datetime = Time.at(data[:dt]).to_s(:db)
    @sunrise = Time.at(data[:sunrise]).to_s(:time)
    @sunset = Time.at(data[:sunset]).to_s(:time)
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
