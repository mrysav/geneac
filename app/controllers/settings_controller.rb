# frozen_string_literal: true

# Basic controller for updating site settings
class SettingsController < ApplicationController
  def create
    authorize :settings, :use?

    setting_params.each_key do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end
    redirect_to settings_path, notice: I18n.t('settings.settings_updated')
  end

  def show
    authorize :settings, :use?
    @env_vars = ['HOSTNAME', 'MAILER_SENDER', 'AWS_REGION', 'S3_BUCKET_NAME']
  end

  private

  def setting_params
    params.require(:setting).permit(*Setting.keys)
  end
end
