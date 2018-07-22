class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :commentable_id, index: true
      t.string  :commentable_type
      t.integer :owner_id
      t.text :body

      t.timestamps null: false
    end
  end
end
