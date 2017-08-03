class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    './uploads/tmp/images'
  end

  def extension_whitelist
    %w[jpg jpeg gif png svg]
  end
end
