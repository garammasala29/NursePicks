# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to @post, notice: 'コメントを投稿しました'
    else
      render @post
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end
end
