# frozen_string_literal: true

class API::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end
