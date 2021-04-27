class Job
  attr_reader :title,
              :min,
              :max
  def initialize(data)
    @title = data[:job][:title]
    @min = format_currency(data[:salary_percentiles][:percentile_25].round(2))
    @max = format_currency(data[:salary_percentiles][:percentile_75].round(2))
  end

  def format_currency(float)
    "$%.2f" % float
  end
end
