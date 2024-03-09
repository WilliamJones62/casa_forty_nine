# frozen_string_literal: true

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users do
        get '/booked', to: "users#booked"
        post '/createbooking', to: "users#createbooking"
        post '/updatebooking', to: "users#updatebooking"
        post '/deletebooking', to: "users#deletebooking"
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
