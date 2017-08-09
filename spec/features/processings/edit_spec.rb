require 'rails_helper'

RSpec.describe 'Processing EDIT' do
  let!(:processing) { create(:processing) }
  let(:x)           { '500' }
  let(:y)           { '313' }
  let(:size)        { Processing::SIZES[0] }
  let(:second_size) { Processing::SIZES[1] }
  let(:third_size)  { Processing::SIZES[2] }
  let(:fourth_size) { Processing::SIZES[3] }

  before            { visit '/processings/1/edit' }

  it 'shows info in alert correctly', js: true do
    find("img[src*='space.jpg']").click

    text = page.driver.browser.switch_to.alert.text

    expect(text).to eq "Selected point:\nLeft: #{x} Top: #{y}"
  end

  it 'goes to show page after submission', js: true do
    find("img[src*='space.jpg']").click
    page.driver.browser.switch_to.alert.accept
    page.choose(size)

    click_button 'Crop Image!'

    expect(page).to have_current_path "/processings/#{processing.friendly_id}"
    expect(page).to have_css("img[src*='cropped_space.jpg']")
  end

  it 'adds correct crop_x and crop_y to form', js: true do
    Capybara.ignore_hidden_elements = false

    find("img[src*='space.jpg']").click
    page.driver.browser.switch_to.alert.accept
    page.choose(size)

    crop_x = find('#crop_x')['value']
    crop_y = find('#crop_y')['value']

    expect(crop_x).to eq(x)
    expect(crop_y).to eq(y)
  end

  it 'updates crop size correctly', js: true do
    find("img[src*='space.jpg']").click
    page.driver.browser.switch_to.alert.accept
    page.choose(size)

    click_button 'Crop Image!'
    processing.reload

    expect(processing.crop_size).to eq(size)
  end

  context 'first edit (before click)' do
    it 'displays page correctly' do
      expect(page).to     have_css("img[src*='space.jpg']")
      expect(page).not_to have_content(size)
      expect(page).not_to have_button('Crop Image!')
    end
  end

  context 'first edit (after click)', js: true do
    it 'displays page correctly' do
      find("img[src*='space.jpg']").click
      page.driver.browser.switch_to.alert.accept

      expect(page).to     have_css("img[src*='space.jpg']")
      expect(page).to     have_content(size)
      expect(page).not_to have_button('Crop Image!')
    end
  end

  context 'first edit (after size selection)', js: true do
    it 'displays page correctly' do
      find("img[src*='space.jpg']").click
      page.driver.browser.switch_to.alert.accept
      page.choose(size)

      expect(page).to have_css("img[src*='space.jpg']")
      expect(page).to have_content(size)
      expect(page).to have_button('Crop Image!')
    end
  end

  context 'second edit' do
    it 'displays page correctly' do
      processing.crop_size = size
      processing.reload

      expect(page).to     have_css("img[src*='space.jpg']")
      expect(page).to     have_content(processing.crop_size)
      expect(page).not_to have_button('Crop Image!')
    end
  end

  context 'image is big enough for all crop sizes', js: true do
    it 'displays all radiobuttons' do
      allow_any_instance_of(Processing::CropPolicy).to receive(:allowed?).and_return(true)
      find("img[src*='space.jpg']").click
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_content(size)
      expect(page).to have_content(second_size)
      expect(page).to have_content(third_size)
      expect(page).to have_content(fourth_size)
    end
  end

  context 'crop point has location that forbids crop creation', js: true do
    it 'displays no radiobuttons' do
      allow_any_instance_of(Processing::CropPolicy).to receive(:allowed?).and_return(false)
      find("img[src*='space.jpg']").click
      page.driver.browser.switch_to.alert.accept

      expect(page).not_to have_content(size)
      expect(page).not_to have_content(second_size)
      expect(page).not_to have_content(third_size)
      expect(page).not_to have_content(fourth_size)
    end
  end

  context 'this image size is not provided' do
    it 'is not valid' do
      processing = build(:processing, crop_size: '100500x100500')

      expect(processing.valid?).to be_falsey
    end
  end
end
