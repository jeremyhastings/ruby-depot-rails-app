class Order < ApplicationRecord
  # Added this prior to migration and using enum to keep track of payment type.  December 10th, 2019.
  enum pay_type: {
      "Check" => 0,
      "Credit card" => 1,
      "Purchase order" => 2
  }
  # Added validation for orders on December 10th, 2019.
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys
end
