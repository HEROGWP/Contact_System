module RequestLogin

  def login_user(user = nil)
    user ||= FactoryGirl.create(:user)
    post_via_redirect user_session_path, { 'user[email]' => user.email, 'user[password]' => "12345678"}
  end

end