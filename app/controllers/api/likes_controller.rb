class Api::LikesController < ApplicationController
  # def index
  # end

  def create
    post = Post.find(params[:id])
    current_user.likes.create!(post: post)
    head :ok
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy!
    head :ok
  end
end
