# frozen_string_literal: true

class EditHistoryPolicy < ApplicationPolicy
  def show?
    return true if admin?

    Pundit.policy(user, record.editable).show?
  end
end
