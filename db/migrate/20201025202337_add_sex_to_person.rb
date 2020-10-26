class AddSexToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :sex, :string
  end
end
