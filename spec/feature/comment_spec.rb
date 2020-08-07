require 'rails_helper'
require 'support/integration_test_helpers'
RSpec.describe 'comments_controller', type: :system do
  include IntegrationTestHelpers
  before :each do
    User.create(name: 'user1', email: 'user1@gmail.com', password: 'password', password_confirmation: 'password')
  end

  it 'create comment' do
    do_login('user1@gmail.com', 'password')
    create_post('hello it is a testing post')
    create_comment('it a testing comment')
    expect(page).to have_content 'Comment was successfully created.'
  end
end
