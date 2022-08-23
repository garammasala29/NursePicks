# frozen_string_literal: true

module SignInHelper
  def sign_in_as(user)
    set_omniauth
    visit root_path
    click_on 'ログイン'
    click_on "#{set_omniauth.provider.capitalize}でログイン"
    @current_user = user
  end

  def current_user
    @current_user
  end
end
