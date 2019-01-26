# frozen_string_literal: true

# Model for people
class Person < ApplicationRecord
  include PgSearch
  multisearchable against: %i[first_name last_name alternate_names
                              date_of_birth date_of_death birthplace
                              burialplace]

  # title is used when this shows up in search results
  def title
    [full_name, lifespan].reject(&:empty?).join(' ')
  end

  # Unfortunately can't get associations to work so
  # relationships are defined by helper functions here.

  def father
    Person.find(father_id) if father_id && Person.exists?(father_id)
  end

  def father=(value)
    self.father_id = value.id if value.id && Person.exists?(value.id)
  end

  def mother
    Person.find(mother_id) if mother_id && Person.exists?(mother_id)
  end

  def mother=(value)
    self.mother_id = value.id if value.id && Person.exists?(value.id)
  end

  def current_spouse
    Person.find(current_spouse_id) if current_spouse_id &&
                                      Person.exists?(current_spouse_id)
  end

  def current_spouse=(value)
    self.current_spouse_id = value.id if value.id && Person.exists?(value.id)
  end

  def children
    Person.where(father_id: id).or(Person.where(mother_id: id))
  end

  def siblings
    Person.where('id != ? AND ((father_id > 0 AND father_id = ?)'\
                 ' OR (mother_id > 0 AND mother_id = ?))',
                 id, father_id, mother_id)
  end

  def date_of_birth
    Date.edtf(super)
  end

  def date_of_birth=(value)
    parsed_date = Date.edtf(value)&.edtf
    super(parsed_date)
  end

  def date_of_death
    Date.edtf(super)
  end

  def date_of_death=(value)
    parsed_date = Date.edtf(value)&.edtf
    super(parsed_date)
  end

  def full_name
    [first_name || '', last_name || ''].reject(&:empty?).join(' ')
  end

  def lifespan
    birth_year = date_of_birth&.year
    death_year = date_of_death&.year

    birth = birth_year || '?'
    death = death_year || (probably_dead? ? '?' : 'Present')
    return "(#{birth} - #{death})" if birth_year || death_year

    ''
  end

  # TODO: maybe account for which generation eventually as well
  # also, obviously a person can live to be older than 90,
  # but the US census releases records after 70 years
  # so I figure I'm good here
  def probably_dead?
    definitely_dead = !date_of_death.nil?
    no_record = !definitely_dead && date_of_birth.nil?
    age = Date.today.year - (date_of_birth&.year || 0)
    definitely_dead || no_record || age > 90
  end

  def probably_alive?
    !probably_dead?
  end

  def main_photo
    Photo.tagged_with(id.to_s, on: :tagged_people)[0]
  end
end
