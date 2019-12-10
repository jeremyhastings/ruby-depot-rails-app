class Product < ApplicationRecord

  # This associates products with line_items.  December 8th, 2019
  has_many :line_items
  has_many :orders, through: :line_items
  # This ensures that no line items are referencing the product before deleting it.  December 8th, 2019.
  before_destroy :ensure_not_referenced_by_any_line_item

  # TODO: image_url has conflicting validation.  It must have a presence of true but it also allows a blank entry.
  # Added to make sure no blank entries are made.  December 7th, 2019.
  validates :title, :description, :image_url, presence: true

  # This line insures that the price is more than free.  December 7th, 2019.
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  # This insures there are no product entries with the same name.  Prevents duplication.  December 7th, 2019.
  validates :title, uniqueness: true

  # TODO: image_url has conflicting validation.  It must have a presence of true but it also allows a blank entry.
  # This will allow no image but if an image is provided it is a .gif, .jpg, or .png file.  December 7th, 2019.
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)\z}i, message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private

    # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
