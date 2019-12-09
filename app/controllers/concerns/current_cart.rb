module CurrentCart

  private

  # This allows the method to be shared by all controllers.  Added December 8th, 2019.
  def set_cart
    # Looks for the cart_id in the session if it is invalid or nil,
    # it will create a new one and set that as the cart_id.
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

end