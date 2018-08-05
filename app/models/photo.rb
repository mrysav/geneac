class Photo < ApplicationRecord
  acts_as_taggable

  has_one_attached :image
end
