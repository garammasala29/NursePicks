# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
    flash[:notice] = 'いいねしました'
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: @post.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = 'いいねを取り消しました'
  end
end
