# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  get '/users/:id' => 'users#show', as: :user

  namespace :admin do
    resources :users
    resources :people
    resources :photos
    resources :notes

    root to: 'users#index'
  end
end
