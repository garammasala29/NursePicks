# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { '看護記事' }
    url { 'https://example.com' }
    site_name { '記事元サイト' }
    image_url { 'https://example.com/image' }
    user
  end
end
