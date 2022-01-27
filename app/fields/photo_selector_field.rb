# frozen_string_literal: true

require 'administrate/field/base'

# Field that allows the user to select a photo from a grid of
# photos the resource is tagged with.
class PhotoSelectorField < Administrate::Field::Base
  def photos
    Photo.tagged_with(resource.id.to_s)
  end

  def to_s
    data.id
  end
end
