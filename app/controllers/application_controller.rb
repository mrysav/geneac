# frozen_string_literal: true

# Parent controller
class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit
  # TODO: disable this if necessary
  after_action :verify_authorized, unless: :devise_controller?

  helper MarkdownHelper
  helper SettingHelper

  protect_from_forgery prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_params = [:name]
    devise_parameter_sanitizer.permit(:sign_up, keys: devise_params)
    devise_parameter_sanitizer.permit(:account_update, keys: devise_params)
  end

  def authorize_list(list, action = :show?)
    skip_authorization if list.empty?
    list.select! do |s|
      authorize s, action
    rescue Pundit::NotAuthorizedError => e
      false
    end
  end

  def authorize_or_nil(record)
    authorize record
  rescue NotAuthorizedError
    nil
  end

  private

  def user_not_authorized
    render file: 'public/404.html', status: :forbidden, layout: false
  end
end
