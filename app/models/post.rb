# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true

  after_create TweetNotifier.new

  def self.scrape(post)
    page = MetaInspector.new(post.url)
    post.title = page.title
    post.image_url = page.meta['og:image'] || 'logo_picks.png'
    post.site_name = page.meta['og:site_name']
  end
end
