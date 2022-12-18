require 'rails_helper'
RSpec.describe 'Static content', type: :system do
  feature 'User logs in and logs out' do
    scenario 'with correct details', js: true do
      User.create(email: 'user@example.com', password: 'password')

      visit '/en/users/sign_in'

      fill_in :user_email, with: 'user@example.com'
      fill_in :user_password, with: 'password'
      click_button 'Log In'
      expect(current_path).to eq '/en'
      expect(page).to have_content 'Signed in successfully'

      click_link 'Account'
      expect(current_path).to eq '/en/users/edit'
      click_button 'Log Out'
      expect(current_path).to eq '/en'
      expect(page).to have_content 'Signed out successfully'
    end

    scenario 'forgot password' do
      visit '/en/users/sign_in'
      click_link 'Forgot your password?'
      expect(current_path).to eq '/en/users/password/new'
    end

    scenario 'Check without register' do
      routes = ['/en/singers', '/en/albums/top_ranked', '/en/albums/worst_ranked']
      routes.each do |path|
        to_path(path)
      end
    end

    def to_path(path)
      visit path
      expect(current_path).to eq '/en/users/sign_in'
    end
  end
end
