class AddProbablyAliveToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :probably_alive, :boolean

    Person.all.each do |p|
      p.save!
    end
  end
end
