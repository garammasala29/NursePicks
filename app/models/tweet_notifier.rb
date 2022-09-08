# frozen_string_literal: true

class TweetNotifier
  def after_create(post)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    if Rails.env.production?
      client.update(<<~TEXT
        新たに「#{post.title}」が投稿されました！
        URL：https://www.nursepicks.jp/posts/#{post.id}
        #NursePicks
      TEXT
                   )
    else
      Rails.logger.info 'Notification to Twitter.'
    end
  end
end
