# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
end
