class CurrentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :condtions, :icon
end
