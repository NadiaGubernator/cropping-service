class Processing < ApplicationRecord
  class Scaling
    def self.call(*args)
      new(*args).call
    end

    def initialize(processing)
      @processing = processing
    end

    def call
      max_crop_for_size
    end

    private

    attr_reader :processing

    def x
      @x ||= processing.crop_x
    end

    def y
      @y ||= processing.crop_y
    end

    def image
      @image ||= MiniMagick::Image.open(processing.image.file.path)
    end

    def max_crop_width
      @max_crop_width ||= [x, image.width - x].min * 2
    end

    def max_crop_height
      @max_crop_height ||= [y, image.height - y].min * 2
    end

    def min_max
      @min_max ||= [max_crop_width, max_crop_height].min
    end

    def max_max
      @max_max ||= [max_crop_width, max_crop_height].max
    end

    def max_crop_for_size
      case processing.crop_size
      when Processing::SIZES[0]
        "#{min_max}x#{min_max}"
      when Processing::SIZES[1]
        "#{min_max}x#{min_max}"
      when Processing::SIZES[2]
        return "#{max_max}x#{max_max * 0.25}" if max_max * 0.25 < max_crop_height
        "#{min_max * 4}x#{min_max}"
      when Processing::SIZES[3]
        return "#{max_max * 0.25}x#{max_max}" if max_max * 0.25 < max_crop_width
        "#{min_max}x#{min_max * 4}"
      end
    end
  end
end
