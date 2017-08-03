require 'rails_helper'

RSpec.describe 'Processing EDIT' do
  let!(:processing) { create(:processing) }

  before            { visit '/processings/1/edit' }

  it 'displays page correctly' do
    expect(page).to have_content 'Crop Image!'
    expect(page).to have_css("img[src*='rails.png']")
  end

  it 'updates processing correctly' do
    click_button 'Crop Image!'

    expect(page).not_to have_content 'Crop Image!'
    expect(page).to have_current_path '/processings/1'
    expect(page).to have_css("img[src*='rails.png']")
  end
end
