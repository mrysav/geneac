# frozen_string_literal: true

# Adds friendly_url to each user-facing model
class AddFriendlyUrlToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :friendly_url, :string, index: true, unique: true
    add_column :photos, :friendly_url, :string, index: true, unique: true
    add_column :notes, :friendly_url, :string, index: true, unique: true

    reversible do |dir|
      dir.up do
        Person.all.each(&:save!)
        Photo.all.each(&:save!)
        Note.all.each(&:save!)
      end
    end
  end
end
