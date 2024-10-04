# frozen_string_literal: true

require "administrate/field/base"

# Custom field for person tag lists in Administrate dashboard.
class PersonTagListField < Administrate::Field::Base
  def names
    data.map { |t| Person.find(t).title if Person.exists?(t) }
  end

  def to_s
    data
  end
end
