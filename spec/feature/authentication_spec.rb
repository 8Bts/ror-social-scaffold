require 'rails_helper'
require 'support/integration_test_helpers'
RSpec.describe 'friendships_controller', type: :system do
  include IntegrationTestHelpers
  before :each do
    User.create(name: 'user1', email: 'user1@gmail.com', password: 'password', password_confirmation: 'password')
  end
  it 'sign up' do
    visit new_user_registration_path
    fill_in('user_name', with: 'user')
    fill_in('user_email', with: 'user@gmail.com')
    fill_in('user_password', with: 'password')
    fill_in('user_password_confirmation', with: 'password')
    click_button('commit')
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'login to your account' do
    do_login('user1@gmail.com', 'password')
    expect(page).to have_content 'Signed in successfully.'
  end
  it 'sign out' do
    visit destroy_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
