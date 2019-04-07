# frozen_string_literal: true

# Controls search-related functions
class SearchController < ApplicationController
  include PgSearch

  def search
    r = PgSearch.multisearch(params[:s]).map(&:searchable)
    authorize_list r
    @total_results = r.count
    @pagy, @results = pagy_array(r, items: 10)
  end

  def tagged
    tag = params[:tag]
    r = []
    Note.tagged_with(tag).each { |n| r.push(n) }
    Photo.tagged_with(tag).each { |p| r.push(p) }
    authorize_list r
    @total_results = r.count
    @pagy, @results = pagy_array(r, items: 10)
    render 'search'
  end
end
