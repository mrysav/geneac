# frozen_string_literal: true

require "administrate/field/text"

# Field that uses Trix for editing
class RichTextAreaField < Administrate::Field::Text
  def to_s
    data
  end
end
