Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get "/listings", to: "listings#index"
  resources :listings do
    resources :bookings, only: [:create, :new]
  end
  resources :bookings, only: [:show, :destroy, :edit, :update]
end
  # resources :listings, only: %i[index create new show destroy]
  #   resources :bookings, only: [ :index, :create, :new, :show, :destroy ]
