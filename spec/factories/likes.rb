# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    id { 1 }
    post
    user { post.user }
  end

  factory :like2, class: Like do
    id { 2 }
    post { 2 }
    user { post.user }
  end
end
