require 'rails_helper'

describe Processing::UpdateCrop do
  let!(:processing) { create(:processing, crop_x: 250, crop_y: 250, crop_size: Processing::SIZES[0]) }

  describe '#call' do
    it 'updates cropped version of image' do
      processing.image.recreate_versions!
      initial_image = MiniMagick::Image.open(processing.image.cropped.file.path)

      processing.crop_size = Processing::SIZES[1]
      described_class.call(processing)

      current_image = MiniMagick::Image.open(processing.image.cropped.file.path)

      expect(initial_image.width).not_to  eq(current_image.width)
      expect(initial_image.height).not_to eq(current_image.height)
    end
  end
end
