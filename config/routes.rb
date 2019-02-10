# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  get '/u/:id' => 'users#show', as: :user

  get  '/photos/:id' => 'photos#show', as: :photo
  get  '/notes/:id'  => 'notes#show', as: :note
  get  '/p/:id'      => 'people#show', as: :person

  get '/search'      => 'search#search', as: :search
  get '/tagged/:tag' => 'search#tagged', as: :tagged

  namespace :ajax do
    get 'tags' => 'ajax#tags'
    get 'people_tags' => 'ajax#people_tags'
    get 'people_tag/:id' => 'ajax#people_tag', as: :people_tag
  end

  mount RailsSettingsUi::Engine, at: 'settings'

  namespace :admin do
    resources :users
    resources :people
    resources :photos
    resources :notes

    root to: 'users#index'
  end
end
