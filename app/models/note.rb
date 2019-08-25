# frozen_string_literal: true

# Model for Note class
class Note < ApplicationRecord
  include PgSearch::Model
  multisearchable against: %i[title content date]

  acts_as_taggable_on :tags, :tagged_people

  def date
    Chronic.parse(date_string)
  end
end
