Rails.application.routes.draw do

  # Added to handle Session and Admin
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  resources :users
  #resources :orders
  #resources :line_items
  #resources :carts
  ## Made the index action of the store controller the root page.  December 8th, 2019.
  #root 'store#index', as: 'store_index'

  # Created by Scaffold for products
  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only; [ :index, :update ]

  # Added for Internationalization.  December 12th, 2019.
  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
