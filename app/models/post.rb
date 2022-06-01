# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
end
