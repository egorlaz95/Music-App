require 'rails_helper'
RSpec.describe 'Static content', type: :system do
  feature 'User registers' do
    scenario 'with valid details' do
      visit '/users/sign_up'

      fill_in :user_email, with: 'tester@example.tld'
      fill_in :user_password, with: 'test-password'
      fill_in :user_password_confirmation, with: 'test-password'
      click_button 'Sign Up'

      expect(current_path).to eq '/en'
      expect(page).to have_content(
        'Welcome! You have signed up successfully.'
      )
    end

    context 'with invalid details' do
      before do
        visit new_user_registration_path
      end

      scenario 'blank fields' do
        fill_in :user_email, with: ''
        fill_in :user_password, with: ''
        fill_in :user_password_confirmation, with: ''

        click_button 'Sign Up'

        expect(page).to have_content("2 errors prohibited this user from being saved:\nEmail can't be blank\nPassword can't be blank")
      end

      scenario 'incorrect password confirmation' do
        fill_in :user_email, with: 'tester@example.tld'
        fill_in :user_password, with: 'test-password'
        fill_in :user_password_confirmation, with: 'not-test-password'
        click_button 'Sign Up'

        expect(page).to have_content("1 error prohibited this user from being saved:\nPassword Confirmation doesn't match Password")
      end

      scenario 'already registered email' do
        User.create(email: 'user@example.com', password: 'password')

        fill_in :user_email, with: 'user@example.com'
        fill_in :user_password, with: 'test-password'
        fill_in :user_password_confirmation, with: 'test-password'
        click_button 'Sign Up'

        expect(page).to have_content("1 error prohibited this user from being saved:\nEmail has already been taken")
      end

      scenario 'too short password' do
        min_password_length = 6
        too_short_password = 'p' * (min_password_length - 1)
        fill_in :user_email, with: 'someone@example.tld'
        fill_in :user_password, with: too_short_password
        fill_in :user_password_confirmation, with: too_short_password
        click_button 'Sign Up'

        expect(page).to have_content("1 error prohibited this user from being saved:\nPassword is too short (minimum is 6 characters)")
      end
    end
  end
end
