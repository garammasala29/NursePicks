# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    id { 1 }
    content { 'コメントテスト' }
    post
    user { post.user }
  end

  factory :comment2, class: Comment do
    id { 2 }
    content { 'コメントテスト2' }
    post
    user { post.user }
  end
end
