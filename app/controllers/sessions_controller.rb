# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.from_omniauth(auth_hash)
    if user
      sign_in(user)
      redirect_to root_path, notice: 'ログインしました'
    else
      redirect_to signup_path(auth_hash)
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
