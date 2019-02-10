# frozen_string_literal: true

require 'rails-settings-ui'

Rails.application.config.to_prepare do
  RailsSettingsUi.settings_class = 'Setting'
  RailsSettingsUi.inline_engine_routes!
  RailsSettingsUi::ApplicationController.module_eval do
    before_action :check_policy

    private

    def check_policy
      authorize :settings, :use?
    end
  end
end
