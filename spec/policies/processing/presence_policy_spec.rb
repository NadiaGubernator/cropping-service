require 'rails_helper'

describe Processing::PresencePolicy do
  let(:processing) { create(:processing) }
  let(:x)          { 0 }
  let(:y)          { 0 }

  describe '#allowed?' do
    context 'x and y are present' do
      it 'allows to pass policy' do
        expect(described_class.new(processing, x, y)).to be_allowed
      end
    end

    context 'x is missing' do
      it 'forbids to pass policy' do
        expect(described_class.new(processing, nil, y)).to_not be_allowed
      end
    end

    context 'y is missing' do
      it 'forbids to pass policy' do
        expect(described_class.new(processing, x, nil)).to_not be_allowed
      end
    end
  end
end
