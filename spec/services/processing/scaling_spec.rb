require 'rails_helper'

describe Processing::Scaling do
  let(:processing) { build(:processing, crop_x: 500, crop_y: 500, crop_size: Processing::SIZES[0]) }

  describe '#call' do
    it 'returns maximal crop size for 50x50' do
      processing.save

      max_crop_for_size = described_class.call(processing)

      expect(max_crop_for_size).to eq('1000x1000')
    end

    it 'returns maximal crop size for 500x500' do
      processing.crop_size = Processing::SIZES[1]
      processing.save

      max_crop_for_size = described_class.call(processing)

      expect(max_crop_for_size).to eq('1000x1000')
    end

    it 'returns maximal crop size for 1000x250' do
      processing.crop_size = Processing::SIZES[2]
      processing.save

      max_crop_for_size = described_class.call(processing)

      expect(max_crop_for_size).to eq('1000x250.0')
    end

    it 'returns maximal crop size for 250x1000' do
      processing.crop_size = Processing::SIZES[3]
      processing.save

      max_crop_for_size = described_class.call(processing)

      expect(max_crop_for_size).to eq('250.0x1000')
    end
  end
end
