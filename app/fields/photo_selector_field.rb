require "administrate/field/base"

class PhotoSelectorField < Administrate::Field::Base
  def to_s
    data
  end
end
