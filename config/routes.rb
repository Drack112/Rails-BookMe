# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  authenticated :user do
    root to: 'home#dashboard', as: :authenticated_root
  end

  resources :booking_types
  resources :bookings, except: %i[index new]

  post 'payment-intent', to: 'bookings#intent'
  get ':booking_link', to: 'users#show', as: :user

  scope '/:booking_link', as: :user do
    resources :bookings, only: %i[index new]
  end

  resources :webhooks, only: :create

  root to: 'home#index'
end
