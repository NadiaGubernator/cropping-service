class Processing < ApplicationRecord
  mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :file_name, use: :slugged

  SIZES = %w[50x50 500x500 1000x250 250x1000].freeze

  validates_presence_of :image

  validates :crop_size, inclusion: { in: Processing::SIZES }, allow_nil: true

  validate  :edit_policy

  def edit_policy
    return unless file_present?
    policy = Processing::EditPolicy.new(self)
    errors.add(:image, 'is too small for cropping!') unless policy.allowed?
  end

  def file_name
    image.file.filename if file_present?
  end

  def file_present?
    Processing::FilePresencePolicy.new(self).allowed?
  end
end
