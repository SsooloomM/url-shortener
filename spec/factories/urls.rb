FactoryBot.define do
  factory :url do
    original_url { Faker::Internet.url }
    short_url { "https://app.domain/" }
  end
end
