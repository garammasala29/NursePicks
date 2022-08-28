# frozen_string_literal: true

module SignInHelper
  def sign_in_as(user, provider = :twitter)
    mock_auth(provider)
    visit root_path
    click_on 'ログイン'
    click_on "#{provider.capitalize}でログイン"
    @current_user = user
  end

  def current_user
    @current_user
  end

  def mock_auth(provider)
    case provider
    when :twitter
      OmniAuth.config.mock_auth[:twitter] =
        OmniAuth::AuthHash.new(
          provider: 'twitter',
          uid: '12345',
          info: {
            name: 'Alice',
            image: 'https://example.com/image'
          }
        )
    when :google
      OmniAuth.config.mock_auth[:google_oauth2] =
        OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid: '67890',
          info: {
            name: 'Bob',
            image: 'https://example.com/image'
          }
        )
    end
  end
end
