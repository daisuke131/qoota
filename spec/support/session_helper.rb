module SessionHelpers

  def login
    @current_user = create(:user)
    @auth_token = @current_user.create_new_auth_token
  end

  def logout
    @current_user = nil
    @auth_token = nil
  end

end