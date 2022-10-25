class Authentication::SignIn
  def initialize(login_params)
    @email = login_params[:email]
    @password = login_params[:password]
  end

  def call
    if user&.authenticate(@password)
      return user
    else
      raise ::EchoError.new(:authentication)
    end
  end

  private

  def user
    @user = User.find_by!(email: @email.downcase)
  end

  def save_token
    user.auth_tokens.where(token_type: 'login', name: 'jwt').last.update!(value: user.token)
  end
end