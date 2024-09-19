# frozen_string_literal: true

# Model for Note class
class Note < ApplicationRecord
  include ParseableDate
  include FriendlyUrlName
  include RecordHistory

  after_save_commit :update_search_document

  has_rich_text :rich_content

  has_one :citation, as: :citable, dependent: :destroy
  accepts_nested_attributes_for :citation

  acts_as_taggable_on :tags, :tagged_people

  has_friendly_url_name field: :friendly_url, field_name: :title

  validates :title, presence: true

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

  def update_search_document
    content = "#{title} #{rich_content.to_plain_text} #{tags.join(' ')}"
    Rails.logger.info content
    doc = SearchDocument.find_or_create_by!(searchable: self)
    doc.content = content
    doc.save!
  end
end
