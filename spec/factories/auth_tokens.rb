FactoryBot.define do
  factory :auth_token do
    association :user
    value { Authenticable::JWT::encode(user_id: user.id, iat: Time.now.to_i ) }
    name { 'jwt' }
    token_type { 'login' }
  end
end