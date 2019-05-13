FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Markdown.emphasis }
    status { Faker::Number.within(0..1) }
  end
end
