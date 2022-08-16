# frozen_string_literal: true

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
  provider: 'twitter',
  uid: '12345',
  info: {
    name: 'Alice',
    image: 'https://example.com/image'
  }
)

OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
  provider: 'google_oauth2',
  uid: '67890',
  info: {
    name: 'Bob',
    image: 'https://example.com/image'
  }
)
