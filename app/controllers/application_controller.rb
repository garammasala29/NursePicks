# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def signed_in?
    current_user.present?
  end

  def sign_out
    session.delete(:user_id)
  end

  def require_signin
    return if current_user

    redirect_to root_path
    flash[:alert] = 'ログインしてください'
  end
end
