# frozen_string_literal: true

require 'commonmarker'

# Photo model
class Photo < ApplicationRecord
  include PgSearch
  multisearchable against: %i[title description date]

  acts_as_taggable

  has_one_attached :image
end
