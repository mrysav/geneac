class CreateImports < ActiveRecord::Migration[5.2]
  def change
    create_table :imports do |t|
      t.string :status
      t.string :format
      t.boolean :merge
      
      t.timestamps
    end
  end
end
