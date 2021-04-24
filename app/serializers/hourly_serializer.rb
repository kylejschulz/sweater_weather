class HourlySerializer
  include FastJsonapi::ObjectSerializer
  attributes :time, :temperature, :conditions, :icon
end
