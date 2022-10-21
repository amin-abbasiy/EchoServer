FactoryBot.define do
  factory :user do
    username { ::Faker::Name.unique.name.sub(' ', '-') }
    email { ::Faker::Internet.email }
    password { 'passcodeAa' }
    password_reset_sent_at { nil }
    encrypted_otp { }
    failed_attempts { 0 }
    verified { true }
    verfied_at { Time.now }
  end
end