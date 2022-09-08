# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true

  def twitter_bot
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    client.update(<<~TEXT
      新たに「#{self.title}」が投稿されました！
      URL：https://www.nursepicks.jp/posts/#{(self.id)}
      #NursePicks
      TEXT
    )
  end
end
