require 'rails_helper'

RSpec.describe 'Processing SHOW' do
  let!(:processing) { create(:processing, crop_x: 25, crop_y: 25, crop_size: Processing::SIZES[0]) }

  before            { visit '/processings/1' }

  it 'displays page correctly' do
    expect(page).to have_css("img[src*='cropped_space.jpg']")
    expect(page).to have_link('Crop another image')
    expect(page).to have_link('Crop the image again')
    expect(page).to have_link('Download')
    expect(page).to have_link('Back to index')
  end

  it 'responds to back button correctly' do
    click_link 'Back to index'

    expect(page).to have_current_path '/processings?created=true'
  end

  it 'responds to crop again button correctly' do
    click_link 'Crop the image again'

    expect(page).to have_current_path '/processings/1/edit'
  end

  it 'responds to crop another button correctly' do
    click_link 'Crop another image'

    expect(page).to have_current_path '/processings/new'
  end

  it 'responds to download button correctly' do
    click_link 'Download'

    expect(page).to have_current_path '/uploads/images/cropped_space.jpg'
  end

  it 'displays correct croped image' do
    processing.image.recreate_versions!
    image = MiniMagick::Image.open(processing.image.cropped.file.path)

    size = Processing::CropParams.call(processing.crop_size)

    expect(image.width).to  eq(size[0])
    expect(image.height).to eq(size[1])
  end
end
