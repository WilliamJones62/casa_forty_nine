# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bookings
  devise_for :users
  get 'house/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'house#home'
end
