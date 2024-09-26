# frozen_string_literal: true

# Controls search-related functions
class SearchController < ApplicationController
  def search
    authenticate_user! if Setting.require_login

    privacy_scope = if Setting.restrict_living_info
                      if user_signed_in? && current_user.admin?
                        PrivacyScope::PRIVATE
                      else
                        PrivacyScope::PUBLIC
                      end
                    else
                      PrivacyScope::PRIVATE
                    end

    # Checking the privacy scope counts as authorization here
    skip_authorization

    search_results = SearchDocument.search(params[:s], privacy_scope)
    @total_results = search_results.count("s.id")
    @pagy, @results = pagy_array(search_results, limit: 10)
  end

  def tagged
    tag = params[:tag]
    r = []
    Note.tagged_with(tag).each { |n| r.push(n) }
    Photo.tagged_with(tag).each { |p| r.push(p) }
    authorize_list r
    @total_results = r.count
    @pagy, @results = pagy_array(r, limit: 10)
    render "search"
  end
end
