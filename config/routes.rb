Rails.application.routes.draw do
  resources :notes, except: [:show]
  resources :home, only: [:index]
  devise_for :users


  devise_scope :user do
    root to: 'devise/sessions#new'
  end
# config/routes.rb
  get '/notes/list', to: 'notes#list', as: 'notes_list'

  get "notes#index", to: "home#index"
  
  resources :users, except: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Defines the root path route ("/")
  # root "posts#index"
end
