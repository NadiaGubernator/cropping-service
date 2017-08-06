require 'rails_helper'

describe Processing::EditPolicy do
  let(:processing)   { build(:processing) }
  let(:minimal_size) { Processing::SIZES[0] }
  let(:wrong_width)  { 10 }
  let(:wrong_height) { 10 }

  describe '#allowed?' do
    context 'minimal crop can be done' do
      it 'allows to pass policy' do
        expect(described_class.new(processing)).to be_allowed
      end
    end

    context 'width is smaller than minimal' do
      it 'forbids to pass policy' do
        allow_any_instance_of(MiniMagick::Image).to receive(:width).and_return(wrong_width)

        expect(described_class.new(processing)).to_not be_allowed
      end
    end

    context 'height is smaller than minimal' do
      it 'forbids to pass policy' do
        allow_any_instance_of(MiniMagick::Image).to receive(:height).and_return(wrong_height)

        expect(described_class.new(processing)).to_not be_allowed
      end
    end
  end
end
