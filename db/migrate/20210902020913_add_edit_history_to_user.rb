# frozen_string_literal: true

# Adds a list of recent edits the user has made on the site
# Stored as JSON to be maximally flexible... and it doesn't need to be queried.
class AddEditHistoryToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :edit_history, :jsonb
  end
end
