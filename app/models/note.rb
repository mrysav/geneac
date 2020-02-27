# frozen_string_literal: true

# Model for Note class
class Note < ApplicationRecord
  include ParseableDate

  include PgSearch::Model
  multisearchable against: %i[title content date]

  has_one :citation, as: :citable
  accepts_nested_attributes_for :citation

  acts_as_taggable_on :tags, :tagged_people

  def date
    parse(date_string)
  end
end
