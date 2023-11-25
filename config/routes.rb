# frozen_string_literal: true

require "resque/server"

Rails.application.routes.draw do
  root "home#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users
  get "/u/:id" => "users#show", as: :user

  get  "/photos/:friendly_url" => "photos#show", as: :photo
  get  "/notes/:friendly_url"  => "notes#show", as: :note

  scope "/p" do
    get "/:friendly_url" => "people#show", as: :person
    get "/:friendly_url/family.json" => "people#family_json", as: :person_family_json
    get "/:friendly_url/family" => "people#show_family", as: :person_family
    get "/:friendly_url/gallery" => "people#show_gallery", as: :person_gallery
  end

  get "/search"      => "search#search", as: :search
  get "/tagged/:tag" => "search#tagged", as: :tagged

  namespace :ajax do
    get "tags" => "ajax#tags"
    get "people_tags" => "ajax#people_tags"
    get "parse_date" => "ajax#parse_date"
  end

  authenticate :user do
    resource :settings

    mount Resque::Server, at: "jobs"
  end

  namespace :admin do
    resources :users
    resources :people
    resources :photos
    resources :notes
    resources :facts
    resources :citations

    get "suggestions/citation/:text" => "citations#suggestions"

    get "/snapshots/initiate" => "snapshots#initiate", as: :initiate_snapshot
    resources :snapshots do
      get "restore" => "snapshots#restore"
    end

    root to: "users#index"
  end
end
