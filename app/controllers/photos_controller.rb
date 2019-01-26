# frozen_string_literal: true

# Controller for displaying photos to end-users
class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
    authorize @photo

    @tagged_people = @photo.tagged_people.map do |p|
      id = p.name.to_i
      Person.find(id) if Person.exists?(id)
    end
  end
end
