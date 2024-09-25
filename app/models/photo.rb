# frozen_string_literal: true

# Photo model
class Photo < ApplicationRecord
  include ParseableDate
  include FriendlyUrlName
  include RecordHistory

  acts_as_taggable_on :tags, :tagged_people

  has_one_attached :image

  has_one :citation, as: :citable, dependent: :destroy
  accepts_nested_attributes_for :citation

  has_friendly_url_name field: :friendly_url, field_name: :title

  after_save_commit :update_search_document

  def date
    parse(date_string)
  end

  def resolved_people
    ids = tagged_people.map { |t| t.name.to_i }
    Person.where(id: ids)
  end

  private

  def update_search_document
    content = "#{title} #{description} #{tags.join(' ')}"
    doc = SearchDocument.find_or_create_by!(searchable: self)
    doc.content = content
    doc.privacy_scope = resolved_people.pluck(:probably_alive).any?
    doc.save!
  end
end
