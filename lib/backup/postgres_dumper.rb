# frozen_string_literal: true

require 'open3'
require 'stringio'

# rubocop:disable Style/StringLiterals
module Backup
  # Provides a way to dump a database using pg_dump
  class PostgresDumper
    # Accepts a hash of database configuration with the keys accepted from database.yml
    # Takes a block that will yield a stream of the dump as it comes in from pg_dump
    def dump(config_hash, &block)
      user = config_hash['username']
      password = config_hash['password']
      database = config_hash['database']
      host = config_hash['host']
      port = config_hash['port']

      Rails.logger.info "Dumping database #{database} for user '#{user}'@#{host}:#{port}"

      command = "pg_dump -h #{host} -p #{port} -U #{user} #{database}"

      unless block
        out, err, status = Open3.capture3({ "PGPASSWORD" => password }, command)
        return out if status.success?

        Rails.logger.error("pg_dump returned an error.\nStatus: #{status}\n#{err}")
        return nil
      end

      IO.popen({ "PGPASSWORD" => password }, command, &block)
    end
  end
end
# rubocop:enable Style/StringLiterals
