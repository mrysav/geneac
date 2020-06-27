# frozen_string_literal: true

# Controller for displaying photos to end-users
class PhotosController < ApplicationController
  def show
    @photo = Photo.where(friendly_url: params[:friendly_url]).first
    authorize @photo

    @tagged_people = @photo.tagged_people.map do |p|
      id = p.name.to_i
      person = Person.find(id) if Person.exists?(id)
      authorize person
      person
    end
  end
end
