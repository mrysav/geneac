# frozen_string_literal: true

class CitationPolicy < ApplicationPolicy
  def show?
    return true if admin?

    Pundit.policy(user, record.citable).show?
  end

  def suggestions?
    edit?
  end
end
