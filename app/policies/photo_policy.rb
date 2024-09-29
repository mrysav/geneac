# Denies access to showing a photo based on site settings.
class PhotoPolicy < ApplicationPolicy
  def show?
    return true if admin?
    return false if Setting.require_login && !logged_in?
    return false if Setting.restrict_living_info && living_people?

    true
  end

  private

  def living_people?
    record.resolved_people.exists?(probably_alive: true)
  end
end
