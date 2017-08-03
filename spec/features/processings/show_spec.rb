require 'rails_helper'

RSpec.describe 'Processing SHOW' do
  let!(:processing) { create(:processing) }

  before            { visit '/processings/1' }

  it 'displays page correctly' do
    expect(page).to have_content 'Crop Image!'
    expect(page).to have_css("img[src*='rails.png']")
  end
end
