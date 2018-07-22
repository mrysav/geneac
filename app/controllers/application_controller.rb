# frozen_string_literal: true

# Parent controller
class ApplicationController < ActionController::Base
  include Pundit
  # TODO: reenable this
  # after_action :verify_authorized

  protect_from_forgery prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_params = [:name]
    devise_parameter_sanitizer.permit(:sign_up, keys: devise_params)
    devise_parameter_sanitizer.permit(:account_update, keys: devise_params)
  end
end
