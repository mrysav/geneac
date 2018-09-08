# frozen_string_literal: true

# Controller for any 'home' actions
class HomeController < ApplicationController
  def index
    @recent_photos = Photo.order('updated_at desc').limit(3)
  end
end
