Rails.application.routes.draw do
  get 'users/new'

  get 'users/create'

  get '/auctions/index2', to: 'auctions#index2'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :auctions do
    resources :bids, only: [:create, :destroy]
    resources :publishings, only: [:create]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end
