# frozen_string_literal: true

require 'commonmarker'

# Model for Note class
class Note < ApplicationRecord
  acts_as_taggable

  def render
    CommonMarker.render_html(content)
  end
end
