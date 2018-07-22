class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|

      t.string :first_name
      t.string :last_name
      t.string :alternate_names
      t.string :gender
      t.string :date_of_birth
      t.string :date_of_death
      t.string :birthplace
      t.string :burialplace

      t.integer :father_id
      t.integer :mother_id
      t.integer :current_spouse_id

      t.timestamps null: false
    end
  end
end
