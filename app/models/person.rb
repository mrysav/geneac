# frozen_string_literal: true

# Model for people
class Person < ApplicationRecord
  include ParseableDate

  has_many :facts, as: :factable
  accepts_nested_attributes_for :facts

  include PgSearch::Model
  multisearchable against: %i[first_name last_name alternate_names
                              birth_date_string death_date_string birthplace
                              burialplace]

  before_save :update_probably_alive

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
    if value.nil?
      self.father_id = nil
    elsif value.id && Person.exists?(value.id)
      self.father_id = value.id
    end
  end

  def mother
    Person.find(mother_id) if mother_id && Person.exists?(mother_id)
  end

  def mother=(value)
    if value.nil?
      self.mother_id = nil
    elsif value.id && Person.exists?(value.id)
      self.mother_id = value.id
    end
  end

  def current_spouse
    Person.find(current_spouse_id) if current_spouse_id &&
                                      Person.exists?(current_spouse_id)
  end

  def current_spouse=(value)
    if value.nil?
      self.current_spouse_id = nil
    elsif value.id && Person.exists?(value.id)
      self.current_spouse_id = value.id
    end
  end

  def children
    Person.where('id != ? AND ((father_id > 0 AND father_id = ?)'\
                 ' OR (mother_id > 0 AND mother_id = ?))',
                 id, id, id)
  end

  def siblings
    Person.where('id != ? AND ((father_id > 0 AND father_id = ?)'\
                 ' OR (mother_id > 0 AND mother_id = ?))',
                 id, father_id, mother_id)
  end

  def birth_date
    parse(birth_date_string)
  end

  def death_date
    parse(death_date_string)
  end

  def full_name
    [first_name || '', last_name || ''].reject(&:empty?).join(' ')
  end

  def lifespan
    birth_year = birth_date&.year
    death_year = death_date&.year

    birth = birth_year || '?'
    death = death_year || (probably_dead? ? '?' : 'Present')
    return "(#{birth} - #{death})" if birth_year || death_year

    ''
  end

  def probably_dead?
    !probably_alive?
  end

  private

  # @todo More sophisticated probably_alive logic
  # Obviously a person can live to be older than 90,
  # but the US census releases records after 70 years
  # so I figure I'm good here
  # Also, what do we do about records that have no birth or death date,
  # but obviously lived and died > 90 years ago?
  def update_probably_alive
    definitely_dead = !death_date.nil?
    age = Date.today.year - (birth_date&.year || 0)
    self.probably_alive = !definitely_dead && age < 90
  end
end
