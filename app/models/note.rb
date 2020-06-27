# frozen_string_literal: true

# Model for Note class
class Note < ApplicationRecord
  include ParseableDate
  include FriendlyUrlName

  has_rich_text :rich_content

  include PgSearch::Model
  multisearchable against: %i[title rich_content date]

  has_one :citation, as: :citable
  accepts_nested_attributes_for :citation

  acts_as_taggable_on :tags, :tagged_people

  has_friendly_url_name field: :friendly_url, field_name: :title

  def date
    parse(date_string)
  end
end
