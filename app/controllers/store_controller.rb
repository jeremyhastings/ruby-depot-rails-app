class StoreController < ApplicationController
  # Added Cart Module from concerns to Store Controller to make Cart visible on index action.  December 9th, 2019.
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
  end
end
