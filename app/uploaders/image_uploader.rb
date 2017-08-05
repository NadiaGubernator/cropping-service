class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  version :cropped, if: :crop_data? do
    process :crop
  end

  def store_dir
    './uploads/images'
  end

  def extension_whitelist
    %w[jpg jpeg gif png svg]
  end

  def crop
    manipulate! do |img|
      img.crop("#{model.crop_size}+#{model.crop_x}+#{model.crop_y}")
    end
  end

  private

  def crop_data?(*)
    !model.crop_x.nil?
  end
end
