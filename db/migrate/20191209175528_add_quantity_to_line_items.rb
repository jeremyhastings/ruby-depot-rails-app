class AddQuantityToLineItems < ActiveRecord::Migration[6.0]
  def change
    # Added default: 1 on December 9th, 2019 prior to migration.
    add_column :line_items, :quantity, :integer, default: 1
  end
end
