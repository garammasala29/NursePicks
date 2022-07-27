# frozen_string_literal: true

class Api::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end
