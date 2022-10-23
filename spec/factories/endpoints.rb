FactoryBot.define do
  factory :endpoint do
    association :user
    path { "/greeting" }
    code { 200 }
    endpoint_type { 0 }
    headers { { "Content-type" => "application/json" } }
    body { "\"{ \"message\": \"Hello, world\" }\"" }
    response { { "Content-type" => "application/json",
                 "message" => "Hello, World!" } }

    trait :with_get do
      verb { "GET" }
      path { "/greet" }
    end

    trait :with_post do
      verb { "POST" }
      path { "/greet_post" }
    end

    trait :with_patch do
      verb { "PATCH" }
    end

    trait :with_delete do
      verb { "DELETE" }
    end

    factory :endpoint_with_get, traits: [:with_get]
    factory :endpoint_with_post, traits: [:with_post]
    factory :endpoint_with_patch, traits: [:with_patch]
    factory :endpoint_with_delete, traits: [:with_delete]
  end
end
