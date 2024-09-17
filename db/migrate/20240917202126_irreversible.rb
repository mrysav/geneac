# frozen_string_literal: true

# This migration comes from acts_as_taggable_on_engine (originally 7)
class Irreversible < ActiveRecord::Migration[6.0]
  def self.up
    # noop
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration "Please run rails db:schema:load"
  end
end
