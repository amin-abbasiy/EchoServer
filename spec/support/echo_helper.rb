def current_user
  @current_user = FactoryBot.create(:user_with_token)

  sign_in(@current_user)

  @current_user
end

def sign_in(user)
  request.headers['Authorization'] = %Q{Bearer #{user.auth_tokens.last.value}} if request.present?
end

def set_invalid_token
  request.headers['Authorization'] = %Q{Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiaWF0IjoxNjY2NTQwMzcyLCJleHAiOjF9.Qg1XPkc } if request.present?
end