# frozen_string_literal: true

# Creates the EditHistory table for storing edit records.
class CreateEditHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :edit_histories do |t|
      t.string :action
      t.string :editable_type
      t.integer :editable_id, index: true, foreign_key: true
      t.timestamp :edited_at
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
