class Cart < ApplicationRecord
  # Added has_many relationship with lineitem on December 8th, 2019.
  has_many :line_items, dependent: :destroy
end
