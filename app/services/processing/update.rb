class Processing < ApplicationRecord
  class Update
    def self.call(*args)
      new(*args).call
    end

    def initialize(processing)
      @processing = processing
    end

    def call
      processing.image.recreate_versions!
    end

    private

    attr_reader :processing
  end
end
