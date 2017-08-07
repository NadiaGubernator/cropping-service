require 'rails_helper'

describe Processing::FilePresencePolicy do
  describe '#allowed?' do
    context 'file is present' do
      it 'allows to pass policy' do
        processing = build(:processing)

        expect(described_class.new(processing)).to be_allowed
      end
    end

    context 'file is missing' do
      it 'forbids to pass policy' do
        processing = build(:processing, image: 'no_file_attached.jpg')

        expect(described_class.new(processing)).to_not be_allowed
      end
    end
  end
end
