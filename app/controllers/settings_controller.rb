# frozen_string_literal: true

# Basic controller for updating site settings
class SettingsController < ApplicationController
  def show
    authorize :settings, :use?
    @env_vars = %w[HOSTNAME MAILER_SENDER AZURE_STORAGE_ACCOUNT_NAME AZURE_STORAGE_CONTAINER]
  end

  def create
    authorize :settings, :use?

    setting_params.each_key do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end
    redirect_to settings_path, notice: I18n.t('settings.settings_updated')
  end

  private

  def setting_params
    params.require(:setting).permit(*Setting.keys)
  end
end
