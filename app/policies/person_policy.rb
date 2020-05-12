# frozen_string_literal: true

# Policy for Person
class PersonPolicy < ApplicationPolicy
  # Restricts listing of Person objects based on current_user and settings
  class Scope < Scope
    def resolve
      # Are an admin
      return scope.all if admin?

      # Not an admin, not logged in, and setting requires login
      return scope.none if Setting.require_login && !logged_in?

      # Not an admin, setting does not require login, setting restricts info
      return scope.where(probably_alive: false) if Setting.restrict_living_info

      # Not an admin, setting does not require login,
      # setting does not restrict info
      scope.all
    end
  end

  def show?
    return true if admin?
    return false if Setting.require_login && !logged_in?
    return record.probably_dead? if Setting.restrict_living_info

    true
  end
end
