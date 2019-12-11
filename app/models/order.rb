# I missed this, unsure when this was supposed to be added.  December 11th, 2019.
#require 'active_model/serializers/xml'
# This is using fake payment processor.  December 11th, 2019.
require 'pago'

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

  def charge!(pay_type_params)
    payment_details = {}
    payment_method = nil

    case pay_type
    when "Check"
      payment_method = :check
      payment_details[:routing] = pay_type_params[:routing_number]
      payment_details[:account] = pay_type_params[:account_number]
    when "Credit card"
      payment_method = :credit_card
      month, year = pay_type_params[:expiration_date].split(//)
      payment_details[:cc_num] = pay_type_params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when "Purchase order"
      payment_method = :po
      payment_details[:po_num] = pay_type_params[:po_number]
    end

    payment_result = Pago.make_payment(
        order_id: id,
        payment_method: payment_method,
        payment_details: payment_details
    )

    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise payment_result.error
    end
  end
end
