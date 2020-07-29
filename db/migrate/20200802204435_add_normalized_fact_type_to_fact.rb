class AddNormalizedFactTypeToFact < ActiveRecord::Migration[6.0]
  def change
    add_column :facts, :normalized_type, :string

    Fact.all.each(&save!)
  end
end
