require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Static content', type: :system do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
    User.create(email: 'admin@example.com', password: 'password')
    User.last.admin!
  end
  context 'Favourite' do
    before do
      visit user_session_path
      fill_in :user_email, with: 'admin@example.com'
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
    scenario 'Album add to favourites' do
      click_link 'Add to favourites' 
      visit favourite_albums_path
			expect(page).to have_content("DAMN\nKendrick Lamar")
    end

		scenario 'Album delete from favourites' do
      click_link 'Add to favourites' 
      click_link 'Delete from favourites'
			visit favourite_albums_path
			expect(page).to_not have_content("DAMN\nKendrick Lamar")
    end

  end
end
