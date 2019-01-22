# frozen_string_literal: true

require 'commonmarker'

# Renders markdown in views.
module MarkdownHelper
  def markdown(text)
    CommonMarker.render_html(text || '').html_safe
  end
end
