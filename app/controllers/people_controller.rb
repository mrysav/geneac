# frozen_string_literal: true

# Controller for displaying people (editing controlled by Administrate)
class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:id])
    @events = events_service.events
  end

  private

  def events_service
    Events::EventsService.new(id: params[:id])
  end
end
