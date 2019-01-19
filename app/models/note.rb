# frozen_string_literal: true

require 'commonmarker'

# Model for Note class
class Note < ApplicationRecord
  include PgSearch
  multisearchable against: %i[title content date]

  acts_as_taggable

  def date
    Date.edtf(super)
  end

  def date=(value)
    parsed_date = Date.edtf(value)&.edtf
    super(parsed_date)
  end

  def render_html
    CommonMarker.render_html(content)
  end
end
