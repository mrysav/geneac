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

  namespace :admin do
    resources :users
    resources :people
    resources :photos
    resources :notes

    root to: 'users#index'
  end
end
