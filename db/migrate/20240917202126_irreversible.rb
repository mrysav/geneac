# frozen_string_literal: true

# This migration blocks backing up migrations that happened before the switch to SQLite
# # Run rails db:schema:load instead plz
class Irreversible < ActiveRecord::Migration[6.0]
  def self.up
    # noop
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration "Please run rails db:schema:load"
  end
end
