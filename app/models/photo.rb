# frozen_string_literal: true

# Photo model
class Photo < ApplicationRecord
  include PgSearch
  multisearchable against: %i[title description date]

  acts_as_taggable

  has_one_attached :image

  def date
    Date.edtf(super)
  end

  def date=(value)
    parsed_date = Date.edtf(value)&.edtf
    super(parsed_date)
  end
end
