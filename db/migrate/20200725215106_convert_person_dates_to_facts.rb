class ConvertPersonDatesToFacts < ActiveRecord::Migration[6.0]
  def up
    add_column :facts, :normalized_type, :string
    Fact.all.each(&save!)

    change_table(:people, bulk: true) do |t|
      t.integer :birth_fact_id
      t.integer :death_fact_id
    end

    Person.all.each do |p|
      fact_for(p, 'birth', p.birth_date_string, p.birthplace)&.save!
      fact_for(p, 'death', p.death_date_string, p.deathplace)&.save!
      fact_for(p, 'burial', p.burial_date_string, p.burialplace)&.save!
      p.save!
    end

    change_table(:people, bulk: true) do |t|
      t.remove :birth_date_string
      t.remove :birthplace
      t.remove :death_date_string
      t.remove :deathplace
      t.remove :burial_date_string
      t.remove :burialplace
    end
  end

  def down
    Rails.logger.warn 'This is a GUARANTEED destructive migration and it will leave the database in a weird state!'

    change_table(:people, bulk: true) do |t|
      t.remove :birth_fact_id
      t.remove :death_fact_id
      t.remove :burial_fact_id

      t.string :birth_date_string
      t.string :birthplace
      t.string :death_date_string
      t.string :deathplace
      t.string :burial_date_string
      t.string :burialplace
    end
  end

  def fact_for(person, type, date, place)
    return unless date || place

    f = Fact.new
    f.factable = person
    f.fact_type = type
    f.date_string = date
    f.place = place

    f
  end
end
