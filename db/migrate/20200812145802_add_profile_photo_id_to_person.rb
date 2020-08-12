class AddProfilePhotoIdToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :profile_photo_id, :integer
  end
end
