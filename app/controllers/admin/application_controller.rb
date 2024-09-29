# frozen_string_literal: true

# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include Administrate::Punditize

    before_action :authenticate_user!
    before_action :authenticate_admin
    before_action :authorize_miniprofiler
    around_action :set_current_user

    helper SettingHelper

    def authenticate_admin
      redirect_to root_path, alert: "Not authorized." unless current_user.admin?
    end

    def authorize_miniprofiler
      Rack::MiniProfiler.authorize_request if Rails.env.development? && current_user&.admin?
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    def set_current_user
      User.current_user = current_user
      yield
    ensure
      User.current_user = nil
    end
  end
end
