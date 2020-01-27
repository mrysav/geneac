# frozen_string_literal: true

# Photo model
class Photo < ApplicationRecord
  include ParseableDate

  include PgSearch::Model
  multisearchable against: %i[title description date]

  acts_as_taggable_on :tags, :tagged_people

  has_one_attached :image

  def date
    parse(date_string)
  end
end
