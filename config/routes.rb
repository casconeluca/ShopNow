Rails.application.routes.draw do
  resources :products
  resources :categories
  resources :users, except: [:new]
  root "pages#home"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
