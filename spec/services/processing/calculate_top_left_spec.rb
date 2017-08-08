require 'rails_helper'

describe Processing::CalculateTopLeft do
  let(:size) { '50x50' }
  let(:x)    { 50 }
  let(:y)    { 100 }

  describe '#call' do
    it 'calculates top left point of crop area' do
      top_left = described_class.call(size, x, y)

      expect(top_left[:x]).to eq(25)
      expect(top_left[:y]).to eq(75)
    end
  end
end
