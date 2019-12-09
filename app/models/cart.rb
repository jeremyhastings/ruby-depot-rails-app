class Cart < ApplicationRecord
  # Added has_many relationship with lineitem on December 8th, 2019.
  has_many :line_items, dependent: :destroy

  # Created add_product method on December 9th, 2019.
  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end
end
