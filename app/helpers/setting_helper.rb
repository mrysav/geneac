# frozen_string_literal: true

# Renders settings in views.
module SettingHelper
  def setting(key)
    Setting[key]
  end
end
