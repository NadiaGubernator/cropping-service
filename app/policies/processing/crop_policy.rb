class Processing < ApplicationRecord
  class CropPolicy
    def initialize(processing, crop_size, crop_x, crop_y)
      @processing = processing
      @crop_size  = crop_size || processing.crop_size
      @crop_x     = crop_x
      @crop_y     = crop_y
    end

    def allowed?
      !crop_size.nil? && width_bigger_than_crop? && height_bigger_than_crop?
    end

    private

    attr_reader :processing, :crop_size, :crop_x, :crop_y

    def image
      @image ||= MiniMagick::Image.open(processing.image.file.path)
    end

    def crop_params
      @crop_params ||= Processing::CropParams.call(crop_size)
    end

    def top_left
      @top_left ||= Processing::CalculateTopLeft.call(crop_size, crop_x, crop_y)
    end

    def width
      @width  ||= crop_params[0] + top_left[:x] if top_left[:x] >= 0
    end

    def height
      @height ||= crop_params[1] + top_left[:y] if top_left[:y] >= 0
    end

    def width_bigger_than_crop?
      return false if width.nil?
      image.width >= width
    end

    def height_bigger_than_crop?
      return false if height.nil?
      image.height >= height
    end
  end
end
