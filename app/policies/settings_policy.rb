# frozen_string_literal: true

# Policy for settings
class SettingsPolicy < ApplicationPolicy
  # You can only see and update settings as an admin.
  def use?
    admin?
  end
end
