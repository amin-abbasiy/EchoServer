FactoryBot.define do
  factory :endpoint do
    association :user
    path { "/greeting" }
    code { 200 }
    endpoint_type { 0 }
    headers {  }
    body {  }
    response {  }

    trait :with_get do
      verb { :get }
    end

    trait :with_post do
      verb { :post }
    end

    trait :with_patch do
      verb { :patch }
    end

    trait :with_delete do
      verb { :delete }
    end

    factory :endpoint_with_get, traits: [:with_get]
  end
end
