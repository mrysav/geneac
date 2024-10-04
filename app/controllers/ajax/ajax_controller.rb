# frozen_string_literal: true

module Ajax
  # For AJAX requests in the admin interface
  class AjaxController < ApplicationController
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    include ParseableDate

    def tags
      authorize :ajax, :tags?
      render json: ActsAsTaggableOn::Tag.all.map(&:name)
    end

    def parse_date
      authorize :ajax, :parse_date?
      parsed = parse(params[:d])&.strftime("%F %R:%S %p")
      render json: parsed
    end

    def people_tags
      authorize :ajax, :people_tags?
      render json: Person.all.map { |p| { label: p.title, value: p.id } }
    end

    private

    def user_not_authorized
      head :unauthorized
    end
  end
end
