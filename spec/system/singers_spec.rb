require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Static content', type: :system do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
    User.create(email: 'admin@example.com', password: 'password')
    User.last.admin!
  end

  context 'Singers admin' do
    before do
      visit user_session_path
      fill_in :user_email, with: 'admin@example.com'
      fill_in :user_password, with: 'password'
      click_button 'Log In'
      visit new_singer_path
    end
    scenario 'Create a singer' do
      fill_in :singer_name, with: 'Kendrick Lamar'
      click_button 'Create Singer'
      assert_text 'Singer was successfully created'
    end

    scenario 'Delete a singer' do
      fill_in :singer_name, with: 'Kendrick Lamar'
      click_button 'Create Singer'
      assert_text 'Singer was successfully created'
      click_button 'Destroy this singer'
      assert_text "Singer and this singer's albums were successfully destroyed."
    end
  end
  scenario 'Create a singer if you are not an admin' do
    visit user_session_path
    fill_in :user_email, with: 'user@example.com'
    fill_in :user_password, with: 'password'
    click_button 'Log In'
    expect(current_path).to eq '/en'
  end
end
