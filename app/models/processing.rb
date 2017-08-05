class Processing < ApplicationRecord
  mount_uploader :image, ImageUploader

  SIZES = %w[50x50 500x500 1000x250 250x1000].freeze

  validates :image, presence: true
end
