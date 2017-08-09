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
      ratio_coords = top_left(scaling, model.crop_x, model.crop_y)

      img.crop("#{scaling}+#{ratio_coords[:x]}+#{ratio_coords[:y]}")
         .resize(model.crop_size)
    end
  end

  private

  def crop_data?(*)
    !model.crop_x.nil?
  end

  def top_left(crop_size, x, y)
    Processing::CalculateTopLeft.call(crop_size, x, y)
  end

  def scaling
    @scaling ||= Processing::Scaling.call(model)
  end
end
