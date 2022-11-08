# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user

  rescue_from Exception, with: :error500
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404
  
  def error404(e)
    logger.error [e, *e.backtrace].join('\n')
    render 'errors/404', status: 404, formats: [:html]
  end

  def error500(e)
    logger.error [e, *e.backtrace].join('\n')
    render 'errors/500', status: 500, formats: [:html]
  end
  
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
