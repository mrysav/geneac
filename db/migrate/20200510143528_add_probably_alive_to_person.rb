class AddProbablyAliveToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :probably_alive, :boolean

    Person.find_each(&:save!)
  end
end
