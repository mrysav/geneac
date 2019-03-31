# frozen_string_literal: true

require 'administrate/field/base'

# Custom field for natural language dates in Administrate dashboard.
class AdvancedDateField < Administrate::Field::Base
  def to_s
    data
  end
end
