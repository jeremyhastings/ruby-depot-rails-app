class StoreController < ApplicationController
  skip_before_action :authorize
  # Added Cart Module from concerns to Store Controller to make Cart visible on index action.  December 9th, 2019.
  include CurrentCart
  before_action :set_cart

  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end
