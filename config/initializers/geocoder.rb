Geocoder.configure do |config|
  config.lookup       = :google # 2,500 requests/day
  config.timeout      = 5
  config.units        = :mi
  # config.cache        = Redis.new
  # config.cache_prefix = 'geocode'
end
