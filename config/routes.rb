# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  get '/u/:id' => 'users#show', as: :user

  get  '/data' => 'data#index', as: :data
  post '/data/import' => 'data#import', as: :imports
  get  '/data/export/:id' => 'data#download', as: :export
  post '/data/export' => 'data#export'

  namespace :admin do
    resources :users
    resources :people
    resources :photos
    resources :notes

    root to: 'users#index'
  end
end
