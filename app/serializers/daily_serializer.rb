class DailySerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon 
end
