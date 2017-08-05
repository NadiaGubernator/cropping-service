require 'rails_helper'

RSpec.describe 'Processing EDIT' do
  let!(:processing) { create(:processing) }
  let(:size)        { Processing::SIZES[1] }

  before            { visit '/processings/1/edit' }

  it 'displays page correctly' do
    expect(page).to have_css("img[src*='rails.png']")
  end

  it 'shows info in alert correctly', js: true do
    find("img[src*='rails.png']").click

    text = page.driver.browser.switch_to.alert.text

    expect(text).to eq "Selected point:\nLeft: 256 Top: 256"
  end

  it 'goes to show page after submission', js: true do
    find("img[src*='rails.png']").click

    page.driver.browser.switch_to.alert.accept

    click_button 'Crop Image!'

    expect(page).to have_current_path '/processings/1'
    expect(page).to have_css("img[src*='cropped_rails.png']")
  end

  it 'adds correct crop_x and crop_y to form', js: true do
    Capybara.ignore_hidden_elements = false

    find("img[src*='rails.png']").click

    page.driver.browser.switch_to.alert.accept

    crop_x = find('#crop_x')['value']
    crop_y = find('#crop_y')['value']

    expect(crop_x).to eq('256')
    expect(crop_y).to eq('256')
  end

  it 'updates crop size correctly' do
    page.choose(size)

    click_button 'Crop Image!'
    processing.reload

    expect(processing.crop_size).to eq(size)
  end
end
