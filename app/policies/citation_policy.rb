class CitationPolicy < ApplicationPolicy
  def show?
    return true if admin?

    Pundit.policy(user, record.citable).show?
  end
end
