# frozen_string_literal: true

class API::PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments, :likes).sort { |a, b| b.likes.size <=> a.likes.size }
  end

  def destroy
    current_user.posts.find(params[:id]).destroy!
    head :no_content
  end
end
