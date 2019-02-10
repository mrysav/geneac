# frozen_string_literal: true

class PersonPolicy < ApplicationPolicy
  def show?
    return true if admin?

    (logged_in? || !Setting.require_login) &&
      (record.probably_dead? || !Setting.restrict_living_info)
  end
end
