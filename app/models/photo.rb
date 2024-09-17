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

  def date
    parse(date_string)
  end

  def resolved_people
    ids = tagged_people.map { |t| t.name.to_i }
    Person.where(id: ids)
  end
end
