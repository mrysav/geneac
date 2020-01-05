class AddAttrsToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :deathplace, :string
    add_column :people, :burial_date_string, :string
  end
end
