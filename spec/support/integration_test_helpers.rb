module IntegrationTestHelpers
  def do_login(email, password)
    visit root_path
    fill_in('user_email', with: email)
    fill_in('user_password', with: password)
    click_button('commit')
  end

  def send_invitation(email, password)
    do_login(email, password)

    click_link('All users')
    click_link('Add to friendlist')
  end

  def create_post(content)
    fill_in('post_content', with: content)
    click_button('commit')
  end

  def create_comment(content)
    fill_in('comment_content', with: content)
    click_button('Comment')
  end
end
