# frozen_string_literal: true

# Controls search-related functions
class SearchController < ApplicationController
  include PgSearch

  def search
    @results = PgSearch.multisearch(params[:s]).map(&:searchable)
  end

  def tagged
    tag = params[:tag]
    @results = []
    Note.tagged_with(tag).each { |n| @results.push(n) }
    Photo.tagged_with(tag).each { |p| @results.push(p) }
    render 'search'
  end
end
