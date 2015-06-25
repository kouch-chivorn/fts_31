Rails.application.routes.draw do
  
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  namespace :admin do
    root "users#index"
    resources :categories do
      resources :questions
    end

    resources :tests, :users, only: [:index, :show, :destroy]
    devise_for :admins, controllers: {sessions: "admin/admins/sessions"}
  end
  
  devise_for :users
  resources :users, only: :show
  resources :tests, except: [:new, :index, :destroy] 
  match "/tests/(:category_id)", to: "tests#index", via: :get
  root "static_pages#home"
  get "admin/:id", to: "admin/admins#show", as: :admin
  match "/help", to: "static_pages#help", via: :get
  match "/about", to: "static_pages#about", via: :get
  match "/contact", to: "static_pages#contact", via: :get
  match "/news", to: "static_pages#news", via: :get
end


