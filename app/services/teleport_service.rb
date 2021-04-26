class TeleportService
  def self.get_ua_id(city)
    response = connection.get("/api/urban_areas/slug:#{city}/")
    ua_id = parse(response)[:ua_id]
  end


  def self.get_salary_info(ua_id)
    response = connection.get("/api/urban_areas/teleport%3A#{ua_id}/salaries/")
    parse(response)
  end

  private

  def self.connection
    conn = Faraday.new(url: 'https://api.teleport.org')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
