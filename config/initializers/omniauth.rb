Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET']
  provider :twitter, ENV['TWITTER_ID'], ENV['TWITTER_SECRET'], { :image_size => 'original' }
end
