# frozen_string_literal: true

module Ajax
  # For AJAX requests in the admin interface
  class AjaxController < ApplicationController
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def tags
      authorize :ajax, :tags?
      render json: ActsAsTaggableOn::Tag.all.map(&:name)
    end

    def people_tags
      authorize :ajax, :people_tags?
      render json: Person.all.map { |p| { label: p.title, value: p.id } }
    end

    private

    def user_not_authorized
      head 401
    end
  end
end
