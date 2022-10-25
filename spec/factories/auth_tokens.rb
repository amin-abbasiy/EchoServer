FactoryBot.define do
  factory :auth_token do
    association :user
    value { Authenticable::JWT::encode({ user_id: user.id, iat: Time.now.to_i })  }
    name { 'jwt' }
    token_type { 'login' }
    expire_at { 24.hours.from_now }
    trait :expired do
      value { Authenticable::JWT::encode({ user_id: user.id, iat: Time.now.to_i }, Time.now - 1.hour)  }
    end

    factory :expired_auth_token, traits: [:expired]
  end
end