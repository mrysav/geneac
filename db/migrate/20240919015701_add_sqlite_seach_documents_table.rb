# frozen_string_literal: true

# Create a table for use in full text search
class AddSqliteSeachDocumentsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :search_documents do |t|
      # Key is a unique identifier for this document
      t.string :key

      # Searchable fields for supporting Rails polymorphism
      t.bigint :searchable_id
      t.string :searchable_type

      t.timestamps

      t.index :key
      t.index %i[searchable_type searchable_id]
    end

    create_virtual_table :fts_search_documents, :fts5, %i[content key]
  end
end
