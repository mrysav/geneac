# frozen_string_literal: true

# Basic controller for updating site settings
class SettingsController < ApplicationController
  def create
    authorize :settings, :use?

    setting_params.each_key do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end
    redirect_to settings_path, notice: 'Setting was successfully updated.'
  end

  def show
    authorize :settings, :use?
  end

  private

  def setting_params
    params.require(:setting).permit(*Setting.keys)
  end
end
