# frozen_string_literal: true

# Model that holds information about a specific 'factable' record
# Factable objects: Person
class Fact < ApplicationRecord
  include ParseableDate

  belongs_to :factable, polymorphic: true
  validates :fact_type, presence: true

  has_many :citations, as: :citable
  accepts_nested_attributes_for :citations

  def date
    parse(date_string)
  end
end
