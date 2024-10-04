class CreateSnapshots < ActiveRecord::Migration[6.0]
  def change
    create_table :snapshots, &:timestamps
  end
end
