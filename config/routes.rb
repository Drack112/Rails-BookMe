Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users

  authenticated :user do
    root to: "home#dashboard", as: :authenticated_root
  end

  resources :booking_types
  resources :bookings, except: [:index, :new]

  get ":booking_link", to: "users#show", as: :user

  scope "/:booking_link", as: :user do
    resources :bookings, only: [:index, :new]
  end

  root to: "home#index"
end
