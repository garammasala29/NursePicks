# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'Alice' }
    icon_url { 'https://example.com/image' }
    url { 'https://example.com' }
    provider { 'twitter' }
    uid { '12345' }
  end

  # factory :user do
  #   id { 2 }
  #   name { 'Bob' }
  #   icon_url { 'https://example.com/image' }
  #   url { 'https://example.com' }
  #   provider { 'google_oauth2' }
  #   uid { '67890' }
  # end
end
