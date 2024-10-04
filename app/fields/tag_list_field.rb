# frozen_string_literal: true

require "administrate/field/base"

# Custom field for tag lists in Administrate dashboard.
class TagListField < Administrate::Field::Base
  def to_s
    data
  end
end
