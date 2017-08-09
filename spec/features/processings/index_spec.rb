require 'rails_helper'

RSpec.describe 'Processing INDEX' do
  context 'before image upload' do
    before { visit '/processings' }

    it 'displays page correctly' do
      expect(page).to     have_content('Welcome!')
      expect(page).to     have_content('How to crop image?')
      expect(page).to     have_content('1. Choose top left point of crop area')
      expect(page).to     have_content('2. Choose crop size')
      expect(page).to     have_link('Start with new image!')
      expect(page).not_to have_link('Crop my image!')
    end

    it 'responds to new image button correctly' do
      click_link 'Start with new image!'

      expect(page).to have_current_path '/processings/new'
    end
  end

  context 'after image upload' do
    before { visit '/processings/new' }

    it 'displays page correctly' do
      attach_file('processing[image]', 'spec/fixtures/images/space.jpg')

      click_button 'Upload image!'

      expect(page).to have_current_path '/processings?created=true'
      expect(page).to have_content('Welcome!')
      expect(page).to have_content('How to crop image?')
      expect(page).to have_content('1. Choose top left point of crop area')
      expect(page).to have_content('2. Choose crop size')
      expect(page).to have_link('Start with new image!')
      expect(page).to have_link('Crop my image!')
    end

    it 'responds to crop image button correctly' do
      attach_file('processing[image]', 'spec/fixtures/images/space.jpg')

      click_button 'Upload image!'
      click_link 'Crop my image!'

      expect(page).to have_current_path '/processings/space-jpg/edit'
    end
  end
end
