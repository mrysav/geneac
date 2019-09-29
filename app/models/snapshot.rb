# frozen_string_literal: true

# ActiveStorage wrapper for storing database backups
class Snapshot < ApplicationRecord
  has_one_attached :archive
end
