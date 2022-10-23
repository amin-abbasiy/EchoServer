FactoryBot.define do
  factory :user do
    username { ::Faker::Name.unique.name.gsub(' ', '-') }
    email { ::Faker::Internet.email }
    password { 'passcodeAa' }
    password_reset_sent_at { nil }
    encrypted_otp {  "Encryption::Encrypt.call('101010')" }
    failed_attempts { 0 }
    verified { true }
    verfied_at { Time.now }

    trait :with_token do
      after(:create) do |user|
        create(:auth_token, user: user)

        user.reload
      end
    end

    factory :user_with_token , traits: [:with_token]
  end
end