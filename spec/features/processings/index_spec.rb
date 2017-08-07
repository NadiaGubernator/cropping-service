require 'rails_helper'

RSpec.describe 'Processing INDEX' do
  context 'before image upload' do
    it 'displays page correctly' do
      visit '/processings'

      expect(page).to     have_content('Welcome!')
      expect(page).to     have_content('How to crop image?')
      expect(page).to     have_content('1. Choose top left point of crop area')
      expect(page).to     have_content('2. Choose crop size')
      expect(page).to     have_link('Start with new image!')
      expect(page).not_to have_link('Crop my image!')
    end
  end

  context 'after image upload' do
    it 'displays page correctly' do
      visit '/processings/new'
      attach_file('processing[image]', 'spec/fixtures/images/rails.png')

      click_button 'Upload image!'

      expect(page).to have_current_path '/processings?created=true'
      expect(page).to have_content('Welcome!')
      expect(page).to have_content('How to crop image?')
      expect(page).to have_content('1. Choose top left point of crop area')
      expect(page).to have_content('2. Choose crop size')
      expect(page).to have_link('Start with new image!')
      expect(page).to have_link('Crop my image!')
    end
  end
end
