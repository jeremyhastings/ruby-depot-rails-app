class Order < ApplicationRecord
  # States that orders have many lineitems.  December 10th, 2019.
  has_many :line_items, dependent: :destroy
  # Added this prior to migration and using enum to keep track of payment type.  December 10th, 2019.
  enum pay_type: {
      "Check" => 0,
      "Credit card" => 1,
      "Purchase order" => 2
  }
  # Added validation for orders on December 10th, 2019.
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  # Added to handle line items being moved into the order and the cart being destroyed.  December 10th, 2019.
  def add_line_items_from_cart(cart)
    # For each item in the cart
    cart.line_items.each do | item |
      # destroy the cart_id
      item.cart_id = nil
      # reinsert the item back into the line_item collection.  This is why cart is optional.  So cart can be destroyed.
      line_items << item
    end
  end
end
