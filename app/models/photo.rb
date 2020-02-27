# frozen_string_literal: true

# Photo model
class Photo < ApplicationRecord
  include ParseableDate

  include PgSearch::Model
  multisearchable against: %i[title description date]

  acts_as_taggable_on :tags, :tagged_people

  has_one_attached :image

  has_one :citation, as: :citable
  accepts_nested_attributes_for :citation

  def date
    parse(date_string)
  end
end
