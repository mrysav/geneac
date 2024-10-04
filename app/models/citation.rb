# frozen_string_literal: true

# Holds a single citation as free-form text
# Citable objects: Facts, Notes, Photos
class Citation < ApplicationRecord
  belongs_to :citable, polymorphic: true
  validates :citable_type, presence: true

  before_save :parse_attrs

  private

  def parse_attrs
    return unless text

    parsed_links = linkify.match(text)

    self.attrs = {
      text:,
      links: parsed_links
    }
  end

  def linkify
    @linkify = Linkify.new
  end
end
