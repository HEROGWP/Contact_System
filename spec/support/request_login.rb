module RequestLogin

    def login_user
      @user ||= FactoryGirl.create(:user)
      post_via_redirect user_session_path, params:{ 'user[email]' => @user.email, 'user[password]' => "12345678"}
    end

    def login_admin
      @user ||= FactoryGirl.create(:admin)
      post_via_redirect user_session_path, params:{ 'user[email]' => @user.email, 'user[password]' => "12345678"}
    end

end