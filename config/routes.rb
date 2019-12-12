Rails.application.routes.draw do

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  # Made the index action of the store controller the root page.  December 8th, 2019.
  root 'store#index', as: 'store_index'

  # Created by Scaffold for products
  resources :products do
    get :who_bought, on: :member
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
