# frozen_string_literal: true

Rack::MiniProfiler.config.position = 'bottom-right'

redis_url = ENV['REDIS_URL']

if redis_url.present?
  Rack::MiniProfiler.config.storage_options = { url: redis_url }
  Rack::MiniProfiler.config.storage = Rack::MiniProfiler::RedisStore
end
