Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get "/listings", to: "listings#index"
  resources :listings do
    resources :bookings, only: [:create, :new]
  end
  resources :bookings, only: [:show, :destroy, :edit, :update]
end
