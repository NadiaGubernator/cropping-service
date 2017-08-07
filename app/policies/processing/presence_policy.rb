class Processing < ApplicationRecord
  class PresencePolicy
    def initialize(x, y)
      @crop_x     = x
      @crop_y     = y
    end

    def allowed?
      crop_x? && crop_y?
    end

    private

    attr_reader :crop_x, :crop_y

    def crop_x?
      !crop_x.nil?
    end

    def crop_y?
      !crop_y.nil?
    end
  end
end
