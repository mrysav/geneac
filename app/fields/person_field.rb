# frozen_string_literal: true

require 'administrate/field/base'

# Custom field for person tag lists in Administrate dashboard.
class PersonField < Administrate::Field::Base
  def person_id
    data
  end

  def to_s
    Person.find(data).title if Person.exists?(data)
  end
end
