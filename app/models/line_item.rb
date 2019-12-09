class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # Added method to produce total_price for Cart. December 9th, 2019.
  def total_price
    product.price * quantity
  end

end
