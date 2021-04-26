class SalariesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination, :forecast, :salaries
end
