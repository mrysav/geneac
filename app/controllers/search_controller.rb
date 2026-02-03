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
    @pagy, @results = pagy(:offset, search_results, count_over: true, limit: 10)
  end

  def tagged
    authenticate_user! if Setting.require_login

    # Taggings are materialized and filtered... not ideal
    skip_authorization

    tag_name = params[:tag]
    taggings = ActsAsTaggableOn::Tagging
               .where(tag_id: ActsAsTaggableOn::Tag
                              .where("LOWER(name) LIKE ? ESCAPE '!'", tag_name))
               .filter do |tag|
                 policy(tag.taggable).show?
               end

    @total_results = taggings.count
    @pagy, @results = pagy(:offset, taggings, limit: 10)

    render "search"
  end
end
