# frozen_string_literal: true

require 'administrate/field/base'

# Custom field for images in Administrate dashboard.
class ImageField < Administrate::Field::Base
  def to_s
    data
  end
end
