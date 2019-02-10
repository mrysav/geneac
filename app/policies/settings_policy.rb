# frozen_string_literal: true

# Policy for settings
class SettingsPolicy < ApplicationPolicy
  def use?
    admin?
  end
end
