# frozen_string_literal: true

class FactPolicy < ApplicationPolicy
  def show?
    return true if admin?

    Pundit.policy(user, record.factable).show?
  end
end
