Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET']
    provider :twitter, ENV['TWITTER_ID'], ENV['TWITTER_SECRET'], { :image_size => 'original' }
  else
    provider :google_oauth2,
      Rails.application.credentials.google[:client_id],
      Rails.application.credentials.google[:client_secret]
    provider :twitter,
      Rails.application.credentials.twitter[:client_id],
      Rails.application.credentials.twitter[:client_secret],
      { :image_size => 'original' }
  end
end
