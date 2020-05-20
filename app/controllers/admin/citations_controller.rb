# frozen_string_literal: true

module Admin
  class CitationsController < Admin::ApplicationController
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   foo = Foo.find(params[:id])
    #   foo.update(params[:foo])
    #   send_foo_updated_email
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #  if current_user.super_admin?
    #    resource_class
    #  else
    #    resource_class.with_less_stuff
    #  end
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

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
