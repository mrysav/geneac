# frozen_string_literal: true

require 'resque/server'

redis_url = ENV['REDIS_URL']

if redis_url.present?
  uri = URI.parse(redis_url)
  REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)

  Resque.redis = REDIS
end
