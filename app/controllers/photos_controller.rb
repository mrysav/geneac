# frozen_string_literal: true

# Controller for displaying photos to end-users
class PhotosController < ApplicationController
  def show
    @photo = Photo.where(friendly_url: params[:friendly_url]).first
    authorize @photo
    @tagged_people = policy_scope(@photo.resolved_people)
  end
end
