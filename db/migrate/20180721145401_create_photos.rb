class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|

      t.string :title
      t.string :description
      t.string :date

      t.timestamps null: false
    end
  end
end
