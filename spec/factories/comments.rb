# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyText' }
    user { nil }
    post { nil }
  end
end
