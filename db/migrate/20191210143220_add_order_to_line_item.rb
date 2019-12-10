class AddOrderToLineItem < ActiveRecord::Migration[6.0]
  def change
    # Changed null to be true.  December 10th, 2019.
    add_reference :line_items, :order, null: true, foreign_key: true
    # Added change column to allow cart_id to be null.  December 10th, 2019.
    change_column :line_items, :cart_id, :integer, null: true
  end
end
