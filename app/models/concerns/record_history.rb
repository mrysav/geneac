# frozen_string_literal: true

# Records EditHistory entries when creating and updating
module RecordHistory
  extend ActiveSupport::Concern

  included do
    after_create :add_create_history
    after_update :add_update_history
  end

  def add_create_history
    return if User.current_user.blank?

    EditHistory.create!(
      action: :create, editable: self, edited_at: created_at, user: User.current_user
    )
  end

  def add_update_history
    return if User.current_user.blank?

    EditHistory.create!(
      action: :update, editable: self, edited_at: updated_at, user: User.current_user
    )
  end
end
