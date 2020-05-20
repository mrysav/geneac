Rack::MiniProfiler.config.position = 'bottom-right'

redis_url = ENV['REDIS_URL']

unless redis_url.blank?
  Rack::MiniProfiler.config.storage_options = { url: redis_url }
  Rack::MiniProfiler.config.storage = Rack::MiniProfiler::RedisStore
end
