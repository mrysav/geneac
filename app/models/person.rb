# frozen_string_literal: true

# Model for people
class Person < ApplicationRecord
  # Unfortunately can't get associations to work so
  # relationships are defined by helper functions here.

  def father
    Person.find(father_id) if father_id && Person.exists?(father_id)
  end

  def mother
    Person.find(mother_id) if mother_id && Person.exists?(mother_id)
  end

  def current_spouse
    Person.find(current_spouse_id) if current_spouse_id && Person.exists?(current_spouse_id)
  end

  def children
    Person.where(father_id: id).or(Person.where(mother_id: id))
  end

  def birth_date
    EDTF.parse(date_of_birth)
  end

  def death_date
    EDTF.parse(date_of_death)
  end

  # TODO: maybe account for which generation eventually as well
  # also, obviously a person can live to be older than 90,
  # but the US census releases records after 70 years
  # so I figure I'm good here
  def probably_dead?
    date_of_death.present? ||
      (date_of_birth.present? &&
       Date.today.year - birth_date.year > 90)
  end

  def probably_alive?
    !probably_dead?
  end
end
