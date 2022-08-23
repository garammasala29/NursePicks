# frozen_string_literal: true

OmniAuth.config.test_mode = true

def set_omniauth(provider = :twitter)
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
