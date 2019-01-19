# frozen_string_literal: true

require 'commonmarker'

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

  def render_html
    CommonMarker.render_html(description)
  end
end
