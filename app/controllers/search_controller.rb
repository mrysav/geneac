# frozen_string_literal: true

# Controls search-related functions
class SearchController < ApplicationController
  include PgSearch

  def search
    @results = PgSearch.multisearch(params[:s])
  end
end
