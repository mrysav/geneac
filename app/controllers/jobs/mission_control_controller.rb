# Base module for jobs-related controllers
module Jobs
  # Base controller for mission-control_jobs
  class MissionControlController < ApplicationController
    before_action :authz

    def authz
      authorize :jobs, :view?
    end
  end
end
