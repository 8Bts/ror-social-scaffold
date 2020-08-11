require 'rails_helper'
require 'support/integration_test_helpers'
RSpec.describe 'friendships_controller', type: :system do
  include IntegrationTestHelpers
  before :each do
    User.create(name: 'user1', email: 'user1@gmail.com', password: 'password', password_confirmation: 'password')
    User.create(name: 'user2', email: 'user2@gmail.com', password: 'password', password_confirmation: 'password')
  end

  it 'sends an invitation to friendship' do
    send_invitation('user1@gmail.com', 'password')
    expect(page).to have_content 'friend request has been sent'
  end

  it 'rejects an invitation' do
    send_invitation('user1@gmail.com', 'password')
    click_link('Sign out')
    do_login('user2@gmail.com', 'password')
    click_link('All users')
    click_link('See Profile')
    click_link('Reject friendship request')
    expect(page).to have_content 'you unfriended user1'
  end

  it 'accepts an ivitation' do
    send_invitation('user1@gmail.com', 'password')
    click_link('Sign out')
    do_login('user2@gmail.com', 'password')
    click_link('All users')
    click_link('See Profile')
    click_link('Accept friendship request')
    expect(page).to have_content 'now you are friend with user1'
  end
end
