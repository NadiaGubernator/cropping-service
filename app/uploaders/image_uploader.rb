class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    'images'
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
