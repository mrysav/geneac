# frozen_string_literal: true

require 'open3'
require 'stringio'

# rubocop:disable Style/StringLiterals
module Backup
  # Provides a way to dump a database using pg_dump
  class PostgresDumper
    def initialize
      # get the current Rails database configuration
      config = Rails.configuration.database_configuration[Rails.env]

      if config['url']
        uri = URI(config['url'])
        @user = uri.user
        @password = uri.password
        @database = uri.path.delete_prefix '/'
        @host = uri.hostname
        @port = uri.port
      else
        @user = config['username']
        @password = config['password']
        @database = config['database']
        @host = config['host']
        @port = config['port']
      end
    end

    # Accepts a hash of database configuration with the keys accepted from database.yml
    # Takes a block that will yield a stream of the dump as it comes in from pg_dump
    def dump(&block)
      Rails.logger.info "Dumping database #{@database} for user '#{@user}'@#{@host}:#{@port}"

      command = "pg_dump -h #{@host} -p #{@port} -U #{@user} #{@database}"
      Rails.logger.info "Running: #{command}"

      unless block
        out, err, status = Open3.capture3({ "PGPASSWORD" => @password }, command)
        return out if status.success?

        Rails.logger.error("pg_dump returned an error.\nStatus: #{status}\n#{err}")
        return nil
      end

      IO.popen({ "PGPASSWORD" => @password }, command, &block)
    end
  end
end
# rubocop:enable Style/StringLiterals
