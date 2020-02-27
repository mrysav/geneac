# frozen_string_literal: true

class CreateCitations < ActiveRecord::Migration[6.0]
  def change
    create_table :citations do |t|
      t.string :citable_type
      t.integer :citable_id

      t.text :text
      t.jsonb :attrs

      t.timestamps
    end
  end
end
