Rails.application.routes.draw do
  
  devise_for :admins, controllers: {sessions: "admins/sessions"}

  namespace :admins do
    root "users#index"
    resources :categories
    resources :users, only: :show
  end
  
  devise_for :users
  
  root "static_pages#home"

  match "/help", to: "static_pages#help", via: :get
  match "/about", to: "static_pages#about", via: :get
  match "/contact", to: "static_pages#contact", via: :get
  match "/news", to: "static_pages#news", via: :get
end


