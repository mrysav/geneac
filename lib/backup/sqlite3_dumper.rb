# frozen_string_literal: true

require "open3"
require "stringio"

module Backup
  # Provides a way to dump a SQLite database to raw SQL
  class Sqlite3Dumper
    def initialize
      # get the current Rails database configuration
      config = Rails.configuration.database_configuration[Rails.env]
      @database_file = config["database"]
    end

    # Accepts a hash of database configuration with the keys accepted from database.yml
    # Takes a block that will yield a stream of the dump as it comes in from sqlite3
    def dump(&block)
      Rails.logger.info "Dumping database #{@database_file}"

      command = "echo \".dump\" | sqlite3 #{@database_file}"

      unless block
        out, err, status = Open3.capture3({}, command)
        return out if status.success?

        Rails.logger.error("Command was not successful.\nStatus: #{status}\n#{err}")
        return nil
      end

      IO.popen({}, command, &block)
    end
  end
end
