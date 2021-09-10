# frozen_string_literal: true

# Stores a single action of edit history for another model.
class EditHistory < ApplicationRecord
  belongs_to :editable, polymorphic: true
  belongs_to :user

  validates :editable_type, presence: true
end
