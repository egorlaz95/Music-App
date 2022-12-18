require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Static content', type: :system do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
    User.create(email: 'admin@example.com', password: 'password')
    User.last.admin!
  end
  context 'Album admin' do
    before do
      visit user_session_path
      fill_in :user_email, with: 'admin@example.com'
      fill_in :user_password, with: 'password'
      click_button 'Log In'
      visit new_singer_path
    end
    scenario 'Create an album if you are admin' do
      fill_in :singer_name, with: 'Kendrick Lamar'
      click_button 'Create Singer'
      visit new_album_path
      fill_in :album_artist, with: 'Kendrick Lamar'
      fill_in :album_title, with: 'DAMN'
      click_button 'Create Album'
      expect(page).to have_content('Album was successfully created')
    end

    scenario 'Delete an album if you are admin' do
      fill_in :singer_name, with: 'Kendrick Lamar'
      click_button 'Create Singer'
      visit new_album_path
      fill_in :album_artist, with: 'Kendrick Lamar'
      fill_in :album_title, with: 'DAMN'
      click_button 'Create Album'
      click_button 'Destroy this album'
      expect(page).to have_content('Album was successfully destroyed.')
    end
  end
  scenario 'Create an album if you are not admin' do
    visit user_session_path
    fill_in :user_email, with: 'user@example.com'
    fill_in :user_password, with: 'password'
    click_button 'Log In'
    visit new_album_path
    expect(current_path).to eq '/en'
  end
end
