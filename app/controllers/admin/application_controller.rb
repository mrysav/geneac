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

    helper SettingHelper

    def authenticate_admin
      redirect_to root_path, alert: 'Not authorized.' unless current_user.admin?
    end

    def authorize_miniprofiler
      Rack::MiniProfiler.authorize_request if current_user&.admin?
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    def add_create_history
      EditHistory.new(action: :create, editable: requested_resource, edited_at: requested_resource.created_at,
                      user: current_user).save!
    end

    def add_update_history
      EditHistory.new(action: :update, editable: requested_resource, edited_at: requested_resource.updated_at,
                      user: current_user).save!
    end
  end
end
