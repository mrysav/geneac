# frozen_string_literal: true

if Rails.env.development?
  Rack::MiniProfiler.config.position = "bottom-right"

  redis_url = ENV.fetch("REDIS_URL", nil)

  if redis_url.present?
    Rack::MiniProfiler.config.storage_options = { url: redis_url }
    Rack::MiniProfiler.config.storage = Rack::MiniProfiler::RedisStore
  end
end
