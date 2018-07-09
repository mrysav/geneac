# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  namespace :admin do
    resources :users

    root to: 'users#index'
  end
end
