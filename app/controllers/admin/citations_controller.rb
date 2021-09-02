# frozen_string_literal: true

module Admin
  # Controller for actions on the Citations model
  class CitationsController < Admin::ApplicationController
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def suggestions
      authorize :citation, :suggestions?
      suggestions = Citation.search_by_text(params[:text])
                            .limit(5)
                            .map(&:text)
                            .uniq
      render json: suggestions
    end

    private

    def user_not_authorized
      head 401
    end
  end
end
