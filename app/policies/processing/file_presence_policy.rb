class Processing < ApplicationRecord
  class FilePresencePolicy
    def initialize(processing)
      @processing = processing
    end

    def allowed?
      !processing.image.file.nil?
    end

    private

    attr_reader :processing
  end
end
