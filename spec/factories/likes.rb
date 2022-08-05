# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    id { 1 }
    post
    user { post.user }
  end
end
