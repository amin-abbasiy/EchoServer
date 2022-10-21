FactoryBot.define do
  factory :auth_token do
    association :user
    value { Authenticable.encode(id: 1) }
    name { 'jwt' }
    token_type { ' jwt' }
  end
end