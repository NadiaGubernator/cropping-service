class Processing < ApplicationRecord
  class CropPolicy
    def initialize(processing, crop_size, x, y)
      @processing = processing
      @crop_size  = crop_size || processing.crop_size
      @crop_x     = x
      @crop_y     = y
    end

    def allowed?
      crop_size? && width_bigger_than_crop? && height_bigger_than_crop?
    end

    private

    attr_reader :processing, :crop_size, :crop_x, :crop_y

    def image
      @image ||= MiniMagick::Image.open(processing.image.file.path)
    end

    def crop_params
      @crop_params ||= crop_size.split('x')
    end

    def crop_size?
      !crop_size.nil?
    end

    def width_bigger_than_crop?
      image.width > (crop_params[0].to_i + crop_x.to_i)
    end

    def height_bigger_than_crop?
      image.height > (crop_params[1].to_i + crop_y.to_i)
    end
  end
end
