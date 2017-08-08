require 'rails_helper'

describe Processing::CropParams do
  let(:size) { '1000x250' }

  describe '#call' do
    it 'divides crop size into two params' do
      params = described_class.call(size)

      expect(params[0]).to eq(1000)
      expect(params[1]).to eq(250)
    end
  end
end
