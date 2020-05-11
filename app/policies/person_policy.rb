# frozen_string_literal: true

class PersonPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope.all if admin?

  #   end
  # end

  def show?
    return true if admin?

    (logged_in? || !Setting.require_login) &&
      (record.probably_dead? || !Setting.restrict_living_info)
  end
end
