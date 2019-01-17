# frozen_string_literal: true

require 'commonmarker'

# Model for Note class
class Note < ApplicationRecord
  include PgSearch
  multisearchable against: %i[title content date]

  acts_as_taggable

  def render_html
    CommonMarker.render_html(content)
  end
end
