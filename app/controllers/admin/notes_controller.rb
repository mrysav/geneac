# frozen_string_literal: true

module Admin
  class NotesController < Admin::ApplicationController
    after_action :add_create_history, only: :create
    after_action :add_update_history, only: :update
  end
end
