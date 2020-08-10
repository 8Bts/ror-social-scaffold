require 'rails_helper'
require 'support/integration_test_helpers'
RSpec.describe 'posts_controller', type: :system do
  include IntegrationTestHelpers
  before :each do
    User.create(name: 'user1', email: 'user1@gmail.com', password: 'password', password_confirmation: 'password')
  end

  it 'create post' do
    do_login('user1@gmail.com', 'password')
    create_post('hello it is a testing post')
    expect(page).to have_content 'Post was successfully created.'
  end
end
