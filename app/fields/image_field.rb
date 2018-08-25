# frozen_string_literal: true

require 'administrate/field/base'

class ImageField < Administrate::Field::Base
  def to_s
    data
  end
end
