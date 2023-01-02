# frozen_string_literal: true

require 'dtree/person_serializer'

# Controller for displaying people
class PeopleController < ApplicationController
  include DTree::Person

  before_action :redirect_to_friendly_url

  def show
    @person = Person.where(friendly_url: params[:friendly_url]).first
    begin
      authorize @person
    rescue Pundit::NotDefinedError
      render file: 'public/404.html', status: :not_found, layout: false
      return
    end

    @events = events_service.events

    respond_to do |format|
      format.html
      format.json do
        render json: @person.to_json(
          except: %i[id father_id mother_id current_spouse_id birth_fact_id death_fact_id],
          methods: %i[title friendly_url]
        )
      end
    end
  end

  def show_family
    @person = Person.where(friendly_url: params[:friendly_url]).first
    begin
      authorize @person
    rescue Pundit::NotDefinedError
      render file: 'public/404.html', status: :not_found, layout: false
      return nil
    end

    @current_spouse = authorize_or_nil(@person.current_spouse) if @person.current_spouse
    @children = policy_scope(@person.children)
    @siblings = policy_scope(@person.siblings)
  end

  def family_json
    person = Person.where(friendly_url: params[:friendly_url]).first
    begin
      authorize person
    rescue Pundit::NotDefinedError
      render json: { error: 'Not found' }, status: :not_found, layout: false
      return nil
    end

    unless Setting.enable_family_tree
      render json: { error: 'Not found' }, status: :not_found, layout: false
      return nil
    end

    render json: serialize_person(person)
  end

  def show_gallery
    @person = Person.where(friendly_url: params[:friendly_url]).first
    begin
      authorize @person
    rescue Pundit::NotDefinedError
      render file: 'public/404.html', status: :not_found, layout: false
      nil
    end

    @notes = Note.tagged_with(@person.id.to_s)
    @photos = Photo.tagged_with(@person.id.to_s)
  end

  private

  def events_service
    Events::EventsService.new(id: @person.id)
  end

  def person_id?(id_param)
    return true if /^[0-9]+$/.match?(id_param)

    false
  end

  # Redirects requests like /p/10 to /p/12345_person_name
  # but only for admins.
  # This can be used to easily direct
  def redirect_to_friendly_url
    return unless current_user&.admin?
    return unless person_id? params[:friendly_url]

    @person = Person.find(params[:friendly_url])
    authorize @person
    redirect_to person_path(@person.friendly_url)
  end
end
