# frozen_string_literal: true

module SignInHelper
  def sign_in_as(user)
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
    visit root_path
    click_on 'ログイン'
    click_on 'Twitterでログイン'
    @current_user = user
  end

  def current_user
    @current_user
  end
end
