# frozen_string_literal: true

# Contains shared methods for jobs
class ApplicationJob < ActiveJob::Base
  include Rails.application.routes.url_helpers
end
