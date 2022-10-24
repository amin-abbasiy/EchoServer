FactoryBot.define do
  factory :endpoint do
    association :user
    path { "/greeting" }
    code { 200 }
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

    trait :get_mock do
      verb { "GET" }
      body { "{ \"message\": \"Hello, world\" }" }
    end

    trait :post_mock do
      verb { "POST" }
      body { "{ \"message\": \"Hello, world\" }" }
    end

    trait :patch_mock do
      verb { "PATCH" }
      body { "{ \"message\": \"Hello, world\" }" }
    end

    trait :put_mock do
      verb { "PUT" }
      body { "{ \"message\": \"Hello, world\" }" }
    end

    trait :delete_mock do
      verb { "DELETE" }
      body { "{ \"message\": \"Hello, world\" }" }
    end

    trait :head_mock do
      verb { "HEAD" }
      body { "{ \"message\": \"There is no message in response\" }" }
    end

    factory :endpoint_with_get, traits: [:with_get]
    factory :endpoint_with_post, traits: [:with_post]
    factory :endpoint_with_patch, traits: [:with_patch]
    factory :endpoint_with_delete, traits: [:with_delete]

    factory :endpoint_mock_get, traits: [:get_mock]
    factory :endpoint_mock_post, traits: [:post_mock]
    factory :endpoint_mock_patch, traits: [:patch_mock]
    factory :endpoint_mock_put, traits: [:put_mock]
    factory :endpoint_mock_delete, traits: [:delete_mock]
    factory :endpoint_mock_head, traits: [:head_mock]
  end
end
