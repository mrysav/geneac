# frozen_string_literal: true

# Adds a privacy_scope attribute to the search documents table
class AddPrivacyScopeToSearchDocumentsTable < ActiveRecord::Migration[8.0]
  def change
    change_table :search_documents do |t|
      t.integer :privacy_scope, null: false, default: 0
    end
  end
end
