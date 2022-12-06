# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'コメントテスト' }
    post
    user { post.user }
  end

  factory :comment2, class: 'Comment' do
    content { 'コメントテスト2' }
    post
    user { post.user }
  end
end
