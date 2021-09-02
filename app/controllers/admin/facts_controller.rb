# frozen_string_literal: true

module Admin
  # Controller for actions on the Facts model
  class FactsController < Admin::ApplicationController
    after_action :add_create_history, only: :create
    after_action :add_update_history, only: :update
  end
end
