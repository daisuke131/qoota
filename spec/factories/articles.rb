FactoryBot.define do
  factory :article do
    title { Faker::Markdown.headers }
    body { Faker::Markdown.emphasis }
    status { Faker::Number.within(0..2) }
  end
end
