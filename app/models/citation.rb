# frozen_string_literal: true

# Holds a single citation as free-form text
# Citable objects: Facts, Notes, Photos
class Citation < ApplicationRecord
  include PgSearch::Model

  belongs_to :citable, polymorphic: true
  validates :citable_type, presence: true

  before_save :parse_attrs

  pg_search_scope :search_by_text, against: :text

  private

  def parse_attrs
    self.attrs = [text]
  end
end
