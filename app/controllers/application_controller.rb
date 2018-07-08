# frozen_string_literal: true

# Parent controller
class ApplicationController < ActionController::Base
  include Pundit
  # TODO: reenable this
  # after_action :verify_authorized

  protect_from_forgery prepend: true
end
