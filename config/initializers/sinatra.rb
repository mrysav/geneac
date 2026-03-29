# frozen_string_literal: true

# Still needs a monkey patch
# https://github.com/resque/resque/issues/1908
Rails.application.config.after_initialize do
  require "sinatra/base"
  class Sinatra::Base
    set :host_authorization, permitted_hosts: Rails.application.config.hosts.map(&:to_s).concat(["127.0.0.1", "localhost"])
  end
end
