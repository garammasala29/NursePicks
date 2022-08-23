# frozen_string_literal: true

module SignInHelper
  def sign_in_as(user)
    mock_auth
    visit root_path
    click_on 'ログイン'
    click_on "#{mock_auth.provider.capitalize}でログイン"
    @current_user = user
  end

  def current_user
    @current_user
  end

  def mock_auth(provider = :twitter)
    OmniAuth.config.mock_auth[provider] = case provider
                                          when :twitter
                                            OmniAuth::AuthHash.new(
                                              provider: 'twitter',
                                              uid: '12345',
                                              info: {
                                                name: 'Alice',
                                                image: 'https://example.com/image'
                                              }
                                            )
                                          when :google_oauth2
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
