# frozen_string_literal: true

# Renders settings in views.
module SettingHelper
  def setting(key)
    Setting.send(key)
  end
end
