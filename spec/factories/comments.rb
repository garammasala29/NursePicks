FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    post { nil }
  end
end
