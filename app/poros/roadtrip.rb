require 'action_view'
include ActionView::Helpers::DateHelper

class Roadtrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
  def initialize(data)
    @id = nil
    @start_city = data[:start_city]
    @end_city = data[:end_city]
    @travel_time = distance_of_time_in_words(data[:travel_time])
    @weather_at_eta = { temperature: data[:weather_at_eta][:temp],
                      conditions: data[:weather_at_eta][:weather].first[:description] }

  end
end
