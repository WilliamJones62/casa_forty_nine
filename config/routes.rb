Rails.application.routes.draw do
  resources :properties
  devise_for :users
  get 'home/landing'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#landing"

  namespace :api do
    get "user_by_email" => "user_by_email#show", as: :user_by_email
  end
end
