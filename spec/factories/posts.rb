# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { '看護記事' }
    url { 'https://example.com' }
    site_name { '記事元サイト' }
    image_url { 'https://example.com/image' }
    user
  end

  factory :post2, class: Post do
    title { '10分前の記事' }
    url { 'https://example.net' }
    site_name { '記事元サイト2' }
    image_url { 'https://example.net/image' }
    user
    created_at { 10.minutes.ago }
  end

  factory :post3, class: Post do
    title { '1日前の記事' }
    url { 'example.org' }
    site_name { '記事元サイト3' }
    image_url { 'https://example.org/image' }
    user
    created_at { 1.day.ago }
  end

  factory :post4, class: Post do
    title { '2日前の記事' }
    url { 'example.edu' }
    site_name { '記事元サイト4' }
    image_url { 'https://example.edu/image' }
    user
    created_at { 2.days.ago }
  end
end
