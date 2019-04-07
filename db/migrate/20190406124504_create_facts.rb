class CreateFacts < ActiveRecord::Migration[5.2]
  def change
    create_table :facts do |t|
      t.string :factable_type
      t.integer :factable_id

      t.string :fact_type
      t.string :date_string
      t.string :place
      t.text :description

      t.timestamps
    end
  end
end
