require 'rails_helper'

RSpec.describe 'Processing CREATE' do
  before do
    visit '/processings/new'
    allow_any_instance_of(Processing::EditPolicy).to receive(:allowed?).and_return(true)
  end

  it 'displays page correctly' do
    expect(page).to have_content('Upload New Image')
    expect(page).to have_content('Local image')
    expect(page).to have_content('Or use url')
    expect(page).to have_button('Upload image!')
    expect(page).to have_link('Back to index')
  end

  it 'responds to back button correctly' do
    click_link 'Back to index'

    expect(page).to have_current_path '/processings'
  end

  describe 'invalid input' do
    context 'no image uploaded' do
      it 'shows error' do
        click_button 'Upload image!'

        expect(page).to have_content "Image can't be blank"
      end
    end

    context 'it is not image' do
      it 'shows error' do
        attach_file('processing[image]', 'spec/spec_helper.rb')

        click_button 'Upload image!'

        expect(page).to have_content 'Image format must be jpg, jpeg, gif, png or svg'
      end
    end

    context 'it is not image' do
      it 'shows error' do
        page.fill_in 'processing[remote_image_url]', with: 'This is not HTTP'

        click_button 'Upload image!'

        expect(page).to have_content 'Image trying to download a file which is not served over HTTP'
      end
    end

    context 'image is too small' do
      it 'shows error' do
        allow_any_instance_of(Processing::EditPolicy).to receive(:allowed?).and_return(false)
        attach_file('processing[image]', 'spec/fixtures/images/space.jpg')

        click_button 'Upload image!'

        expect(page).to have_content 'Image is too small for cropping!'
      end
    end
  end

  describe 'valid input' do
    context 'local image' do
      it 'creates processing' do
        attach_file('processing[image]', 'spec/fixtures/images/space.jpg')

        click_button 'Upload image!'

        expect(page).to have_current_path '/processings?created=true'
      end

      context 'from url' do
        it 'creates processing' do
          page.fill_in 'processing[remote_image_url]', with: 'http://rubyonrails.org/images/rails-logo.svg'

          click_button 'Upload image!'

          expect(page).to have_current_path '/processings?created=true'
        end
      end
    end
  end
end
