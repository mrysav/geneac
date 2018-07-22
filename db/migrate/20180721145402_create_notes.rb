class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string  :title
      t.string  :date
      t.text    :content
      t.string  :tag_list

      t.timestamps null: false
    end
  end
end
