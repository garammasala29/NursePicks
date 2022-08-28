# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    post
    user { post.user }
  end

  factory :like2, class: Like do
    post { 2 }
    user { post.user }
  end
end
