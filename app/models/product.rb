class Product < ApplicationRecord
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
end
