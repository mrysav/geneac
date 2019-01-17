class CreatePgSearchDocuments < ActiveRecord::Migration[5.2]
  def self.up
    say_with_time("Creating table for pg_search multisearch") do
      execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm;'
      execute 'CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;'

      create_table :pg_search_documents do |t|
        t.text :content
        t.belongs_to :searchable, :polymorphic => true, :index => true
        t.timestamps null: false
      end
    end
  end

  def self.down
    say_with_time("Dropping table for pg_search multisearch") do
      drop_table :pg_search_documents

      execute 'DROP EXTENSION IF EXISTS pg_trgm;'
      execute 'DROP EXTENSION IF EXISTS fuzzystrmatch;'
    end
  end
end
