# frozen_string_literal: true

# Controller for displaying people (editing controlled by Administrate)
class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:id])
  end
end
