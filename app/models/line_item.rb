class LineItem < ApplicationRecord
  # Added line to indicate that lineItem can belong to an order.  December 10th, 2019.
  belongs_to :order, optional: true
  belongs_to :product, optional: true # Added optional: true on december 10th, 2019.
  belongs_to :cart

  # Added method to produce total_price for Cart. December 9th, 2019.
  def total_price
    product.price * quantity
  end

end
