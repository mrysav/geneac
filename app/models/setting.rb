# frozen_string_literal: true

# RailsSettings Model
class Setting < RailsSettings::Base
  # When this file is updated, bump the cache_prefix
  cache_prefix { "2" }

  field :site_title, default: "Geneac"
  field :site_tagline, default: "Genealogy for maniacs!"

  field :require_login, type: :boolean, default: false
  field :restrict_living_info, type: :boolean, default: true
  field :show_recent_updates, type: :boolean, default: true
  field :show_recent_birthdays, type: :boolean, default: true

  field :enable_family_tree, type: :boolean, default: false
end
