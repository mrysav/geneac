# frozen_string_literal: true

# Records EditHistory entries when creating and updating
module RecordHistory
  extend ActiveSupport::Concern

  included do
    after_create :add_create_history, unless: :skip_history_callbacks
    after_update :add_update_history, unless: :skip_history_callbacks
  end

  def skip_history_callbacks
    @skip_history_callbacks || false
  end

  def add_create_history
    EditHistory.create!(
      action: :create, editable: self, edited_at: created_at, user: User.current_user
    )
  end

  def add_update_history
    EditHistory.create!(
      action: :update, editable: self, edited_at: updated_at, user: User.current_user
    )
  end

  def save_without_history!
    @skip_history_callbacks = true
    save!
    @skip_history_callbacks = false
  end
end
