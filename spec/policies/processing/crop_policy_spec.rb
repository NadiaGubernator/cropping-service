require 'rails_helper'

describe Processing::CropPolicy do
  let(:processing) { create(:processing) }
  let(:x)          { 0 }
  let(:y)          { 0 }
  let(:wrong_x)    { 500 }
  let(:wrong_y)    { 500 }
  let(:size)       { Processing::SIZES[0] }
  let(:wrong_size) { Processing::SIZES[2] }

  describe '#allowed?' do
    context 'crop can be done' do
      it 'allows to pass policy' do
        expect(described_class.new(processing, size, x, y)).to be_allowed
      end
    end

    context 'needed params are missing' do
      it 'forbids to pass policy' do
        expect(described_class.new(processing, nil, nil, nil)).to_not be_allowed
      end
    end

    context 'width is smaller than crop size + crop point width' do
      it 'forbids to pass policy' do
        expect(described_class.new(processing, size, wrong_x, y)).to_not be_allowed
      end
    end

    context 'height is smaller than crop size + crop point height' do
      it 'forbids to pass policy' do
        expect(described_class.new(processing, size, x, wrong_y)).to_not be_allowed
      end
    end

    context 'crop size is bigger than picture' do
      it 'forbids to pass policy' do
        expect(described_class.new(processing, wrong_size, x, y)).to_not be_allowed
      end
    end
  end
end
