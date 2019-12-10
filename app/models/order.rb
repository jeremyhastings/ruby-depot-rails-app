class Order < ApplicationRecord
  # Added this prior to migration and using enum to keep track of payment type.  December 10th, 2019.
  enum pay_type: {
      "Check" => 0,
      "Credit card" => 1,
      "Purchase order" => 2
  }
end
