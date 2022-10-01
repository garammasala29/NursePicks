# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
  acts_as_taggable_on :tags

  after_create TweetNotifier.new

  def scrape
    page = MetaInspector.new(url)
    self.title = page.title
    self.image_url = page.meta['og:image'].presence || 'logo_picks.png'
    self.site_name = page.meta['og:site_name']
  end
end
