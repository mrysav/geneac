# frozen_string_literal: true

require 'commonmarker'

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
    Date.edtf(date_of_birth)
  end

  def death_date
    Date.edtf(date_of_death)
  end

  def full_name
    [first_name, last_name].reject(&:empty?).join(' ')
  end

  def lifespan
    bday = date_of_birth.presence || '?'
    dday = date_of_death.presence || (probably_dead? ? '?' : 'Present')
    if bday == '?' && dday == '?'
      ''
    else
      '(' + bday + ' - ' + dday + ')'
    end
  end

  # TODO: maybe account for which generation eventually as well
  # also, obviously a person can live to be older than 90,
  # but the US census releases records after 70 years
  # so I figure I'm good here
  def probably_dead?
    death_date.present? ||
      (birth_date.present? &&
       Date.today.year - birth_date.year > 90)
  end

  def probably_alive?
    !probably_dead?
  end

  def events
    events = []

    unless date_of_birth.blank?
      events.push(title: 'Birth', date: birth_date,
                  location: birthplace || 'Unknown',
                  note: '')
    end

    unless date_of_death.blank?
      events.push(title: 'Burial', date: death_date,
                  location: burialplace || 'Unknown',
                  note: '')
    end

    events
  end

  def render_bio
    CommonMarker.render_html(bio || '')
  end
end
