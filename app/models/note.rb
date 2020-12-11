# frozen_string_literal: true

# Model for Note class
class Note < ApplicationRecord
  include ParseableDate
  include FriendlyUrlName

  has_rich_text :rich_content

  include PgSearch::Model
  multisearchable against: %i[title rich_content date]

  has_one :citation, as: :citable, dependent: :destroy
  accepts_nested_attributes_for :citation

  acts_as_taggable_on :tags, :tagged_people

  has_friendly_url_name field: :friendly_url, field_name: :title

  def date
    parse(date_string)
  end

  def resolved_people
    ids = tagged_people.map { |t| t.name.to_i }
    Person.where(id: ids)
  end

  private

  def parse_possible_names
    name_rgx = /([A-Z][a-z]+ ?){2}([A-Z][a-z]+ ?)*/
  end
end
