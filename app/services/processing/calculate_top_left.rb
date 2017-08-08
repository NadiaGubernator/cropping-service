class Processing < ApplicationRecord
  class CalculateTopLeft
    def self.call(*args)
      new(*args).call
    end

    def initialize(crop_size, crop_x, crop_y)
      @crop_size = crop_size
      @crop_x    = crop_x
      @crop_y    = crop_y
    end

    def call
      { x: x, y: y }
    end

    private

    attr_reader :crop_size, :crop_x, :crop_y

    def crop_params
      @crop_params ||= Processing::CropParams.call(crop_size)
    end

    def half_width
      crop_params[0] / 2
    end

    def half_height
      crop_params[1] / 2
    end

    def x
      crop_x.to_i - half_width
    end

    def y
      crop_y.to_i - half_height
    end
  end
end
