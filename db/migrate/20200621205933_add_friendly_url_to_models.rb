# frozen_string_literal: true

# Adds friendly_url to each user-facing model
class AddFriendlyUrlToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :friendly_url, :string, unique: true
    add_index :people, :friendly_url
    add_column :photos, :friendly_url, :string, unique: true
    add_index :photos, :friendly_url
    add_column :notes, :friendly_url, :string, unique: true
    add_index :notes, :friendly_url

    reversible do |dir|
      dir.up do
        Person.find_each(&:save!)
        Photo.find_each(&:save!)
        Note.find_each(&:save!)
      end
    end
  end
end
