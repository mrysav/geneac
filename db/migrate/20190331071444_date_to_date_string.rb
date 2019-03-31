class DateToDateString < ActiveRecord::Migration[5.2]
  def change
    rename_column :notes, :date, :date_string

    rename_column :photos, :date, :date_string

    rename_column :people, :date_of_birth, :birth_date_string
    rename_column :people, :date_of_death, :death_date_string
  end
end
