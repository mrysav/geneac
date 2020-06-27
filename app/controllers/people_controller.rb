# frozen_string_literal: true

# Controller for displaying people (editing controlled by Administrate)
class PeopleController < ApplicationController
  def show
    @person = Person.where(friendly_url: params[:friendly_url]).first
    authorize @person

    @current_spouse = authorize_or_nil(@person.current_spouse) if @person.current_spouse

    @tab = %w[bio family gallery].include?(params[:t]) ? params[:t] : :bio

    @children = policy_scope(@person.children)
    @siblings = policy_scope(@person.siblings)

    @events = events_service.events
    @notes = Note.tagged_with(@person.id.to_s)
    @photos = Photo.tagged_with(@person.id.to_s)
  end

  private

  def events_service
    Events::EventsService.new(id: @person.id)
  end
end
