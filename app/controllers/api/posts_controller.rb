# frozen_string_literal: true

class API::PostsController < ApplicationController
  before_action :require_signin, only: %i[destroy]

  def index
    @posts = Post.includes(:comments, :likes, :tags, :tag_taggings)
  end

  def destroy
    current_user.posts.find(params[:id]).destroy!
    head :no_content
  end
end
