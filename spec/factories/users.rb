# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'Alice' }
    icon_url { 'https://example.com/image' }
    url { 'https://example.com' }
    provider { 'Twitter' }
    uid { 'a7ed37f9-56bb-4ed1-b858-2129492b9f68' }
  end
end
