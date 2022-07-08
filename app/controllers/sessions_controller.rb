# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_from_omniauth(auth_hash)
    if user
      sign_in(user)
      redirect_to root_path, notice: 'ログインしました'
    else
      @user = User.new_from_omniauth(auth_hash)
      render 'users/new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
