def current_user
  @current_user = FactoryBot.create(:user_with_token)
  request.headers['Authorization'] = %Q{Bearer #{@current_user.auth_tokens.last.value}} if request.present?

  @current_user
end