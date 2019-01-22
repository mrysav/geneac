# frozen_string_literal: true

# Controller for displaying photos to end-users
class PhotosController < ApplicationController
  helper MarkdownHelper

  def show
    @photo = Photo.find(params[:id])
  end
end
