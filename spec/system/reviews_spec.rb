require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Static content', type: :system do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
    User.last.admin!
  end

  context 'reviews' do
    before do
      visit user_session_path
      fill_in :user_email, with: 'user@example.com'
      fill_in :user_password, with: 'password'
      click_button 'Log In'
      visit new_singer_path
      fill_in :singer_name, with: 'Kendrick Lamar'
      click_button 'Create Singer'
      visit new_album_path
      fill_in :album_artist, with: 'Kendrick Lamar'
      fill_in :album_title, with: 'DAMN'
      click_button 'Create Album'
    end

    scenario 'Check the right root' do
      visit '/en/albums/1'
      click_link 'Write Review'
      expect(current_path).to eq '/en/albums/1/reviews/new'
    end

    scenario 'Create a review' do
      visit '/en/albums/1'
      click_link 'Write Review'
      fill_in :review_rating, with: 10
      fill_in :review_comment, with: 'The Best!'
      click_button 'Create Review'
      expect(page).to have_content('Review was successfully created')
    end

    scenario 'Delete a review' do
      visit '/en/albums/1'
      click_link 'Write Review'
      fill_in :review_rating, with: 10
      fill_in :review_comment, with: 'The Best!'
      click_button 'Create Review'
      click_button 'Delete this review'
      expect(page).to have_content('Review was successfully destroyed.')
    end

    scenario 'Check an average rating of the album' do
      visit '/en/albums/1'
      click_link 'Write Review'
      fill_in :review_rating, with: 10
      fill_in :review_comment, with: 'The Best!'
      click_button 'Create Review'
      click_link 'Write Review'
      fill_in :review_rating, with: 9
      fill_in :review_comment, with: 'Close to be the Best!'
      click_button 'Create Review'
      expect(page).to have_content("Average Rating:\n9.5")
    end

    scenario 'Check that an average rating of the album will not be 0 if there are no reviews' do
      visit '/en/albums/1'
      expect(page).not_to have_content("Average Rating:\n0")
    end

    scenario 'Check an average rating of the singer' do
      visit '/en/albums/1'
      click_link 'Write Review'
      fill_in :review_rating, with: 10
      fill_in :review_comment, with: 'The Best!'
      click_button 'Create Review'
      click_link 'Write Review'
      fill_in :review_rating, with: 9
      fill_in :review_comment, with: 'Close to be the Best!'
      click_button 'Create Review'
      visit '/en/singers/1'
      expect(page).to have_content("Average Rating:\n9.5")
    end

    scenario 'Check that an average rating of the singer will not be 0 if there are no reviews' do
      visit '/en/singers/1'
      expect(page).not_to have_content("Average Rating:\n0")
    end
  end
end
