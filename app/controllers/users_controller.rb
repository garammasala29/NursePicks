# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def new
    @user = User.new
    @user.name = params[:info][:name]
    @user.icon_url = params[:info][:image]
    @user.provider = params[:provider]
    @user.uid = params[:uid]
  end

  def show; end

  def create
    @user = User.create(user_params)
    if @user.save
      sign_in(@user)
      redirect_to @user, notice: 'アカウントを登録しました'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報を編集しました'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    edirect_to root_path, notice: 'アカウントを削除しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :url, :provider, :uid, :icon_url)
  end
end
