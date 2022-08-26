# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    id { 1 }
    title { '看護記事' }
    url { 'https://example.com' }
    site_name { '記事元サイト' }
    image_url { 'https://example.com/image' }
    user
  end

  factory :post2, class: Post do
    id { 2 }
    title { '看護記事2' }
    url { 'https://example2.com' }
    site_name { '記事元サイト2' }
    image_url { 'https://example2.com/image' }
    user
  end
end
