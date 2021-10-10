# frozen_string_literal: true

# Model that holds information about a specific 'factable' record
# Factable objects: Person
class Fact < ApplicationRecord
  include ParseableDate
  include RecordHistory
  include SqlFunctions

  module Types
    BIRTH = 'birth'
  end

  belongs_to :factable, polymorphic: true, optional: true
  validates :fact_type, presence: true

  has_many :citations, as: :citable, dependent: :destroy
  accepts_nested_attributes_for :citations

  acts_as_taggable_on :tags, :tagged_people

  before_save :update_normalized_type

  scope :birth_dates, -> { where(fact_type: Types::BIRTH) }
  scope :birthdays_in_range, lambda { |start_date, end_date, limit|
    add_valid_date_function
    date_in_current_year =
      "make_date(date_part('year', current_date)::int, date_part('month', date_string::date)::int, " \
      "date_part('day', date_string::date)::int)"
    includes(:factable)
      .birth_dates
      .where(
        'CASE is_valid_date(date_string) WHEN true THEN ' \
        "(#{date_in_current_year} >= ? AND #{date_in_current_year} <= ?) ELSE false END",
        start_date, end_date
      )
      .order(Arel.sql(date_in_current_year))
      .limit(limit)
  }

  def date
    parse(date_string)
  end

  def resolved_people
    ids = tagged_people.map { |t| t.name.to_i }
    Person.where(id: ids)
  end

  # Updates the 'normalized' fact type so a fact can be mapped to
  # something like a birthday even if the fact type is different.
  # ('birth' vs 'birthdate' etc)
  def update_normalized_type
    self.normalized_type = fact_type.downcase.strip
    self.normalized_type = 'birth' if normalized_type.starts_with? 'birth'
  end
end
