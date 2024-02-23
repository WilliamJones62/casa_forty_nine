# frozen_string_literal: true

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users do
        get '/booked/:year/:month', to: "users#booked"
        get '/booking/:selected', to: "users#booking"
        resources :bookings
      end
    end
  end

  # these routes are for the admin to easily access all the bookings and ament them as needed
  resources :bookings

  devise_for :users
  get 'house/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'house#home'
end
