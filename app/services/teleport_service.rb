class TeleportService
  def self.get_ua_id(city)
    response = Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{city}/")
    ua_id = parse(response)
    require "pry"; binding.pry
  end


  def self.get_salary_info(ua_id)
    response = Faraday.get("https://api.teleport.org/api/urban_areas/teleport%3A#{ua_id}/salaries/")
    parse(response)
    require "pry"; binding.pry
  end

  private

  # def self.connection
  #   conn = Faraday.new(url: 'http://www.mapquestapi.com')
  # end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
