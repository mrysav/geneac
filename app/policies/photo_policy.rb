# frozen_string_literal: true

class PhotoPolicy < ApplicationPolicy
  def show?
    return true if admin?

    (logged_in? || !Setting.require_login) &&
      (record.tagged_person_list.empty? || !Setting.restrict_living_info)
  end
end
