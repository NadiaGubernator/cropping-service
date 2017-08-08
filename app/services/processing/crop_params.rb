class Processing < ApplicationRecord
  class CropParams
    def self.call(*args)
      new(*args).call
    end

    def initialize(crop_size)
      @crop_size = crop_size
    end

    def call
      crop_params
    end

    private

    attr_reader :crop_size

    def crop_params
      crop_size.split('x').map(&:to_i)
    end
  end
end
