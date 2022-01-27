# frozen_string_literal: true

require 'administrate/field/base'

# Custom field for person tag lists in Administrate dashboard.
class PersonTagListField < Administrate::Field::Base
  def names
    data.map { |t| Person.find_by(id: t)&.title }
  end

  def to_s
    data
  end
end
