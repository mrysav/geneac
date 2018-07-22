# frozen_string_literal: true

class Person < ApplicationRecord

  # Unfortunately can't get associations to work so defining relationships manually here.

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
end
