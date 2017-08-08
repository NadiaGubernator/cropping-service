class Processing < ApplicationRecord
  class EditPolicy
    def initialize(processing)
      @processing = processing
    end

    def allowed?
      width_bigger_than_minimal? && height_bigger_than_minimal?
    end

    private

    attr_reader :processing

    def image
      @image ||= MiniMagick::Image.open(processing.image.file.path)
    end

    def minimal_size
      @minimal_size ||= Processing::CropParams.call(Processing::SIZES[0])
    end

    def width_bigger_than_minimal?
      image.width >= minimal_size[0]
    end

    def height_bigger_than_minimal?
      image.height >= minimal_size[1]
    end
  end
end
