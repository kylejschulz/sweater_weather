class Daily
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon
  def initialize(data)
    @datetime = data[:dt]
    @sunrise = data[:sunrise]
    @sunset = data[:sunset]
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
