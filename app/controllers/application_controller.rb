# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :signed_in?

  def signed_in?
    !!session[:user_id]
  end
end
