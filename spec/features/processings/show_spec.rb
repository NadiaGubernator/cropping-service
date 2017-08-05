require 'rails_helper'

RSpec.describe 'Processing SHOW' do
  let!(:processing) { create(:processing, crop_x: 10, crop_y: 10, crop_size: Processing::SIZES[0]) }

  before            { visit '/processings/1' }

  it 'displays page correctly' do
    expect(page).to have_css("img[src*='cropped_rails.png']")
    expect(page).to have_link('Crop another picture')
    expect(page).to have_link('Crop the picture again')
    expect(page).to have_link('Download')
  end

  it 'displays correct croped image' do
    processing.image.recreate_versions!
    image = MiniMagick::Image.open(processing.image.cropped.file.path)

    size = processing.crop_size.split('x')

    expect(image.width).to  eq(size[0].to_i)
    expect(image.height).to eq(size[1].to_i)
  end
end
