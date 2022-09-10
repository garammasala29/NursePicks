# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]
  before_action :require_signin, only: %i[create destroy]

  def index
    @post = Post.new
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def create
    @post = current_user.posts.create(post_params)

    begin
      Post.scrape(@post)
    rescue StandardError
      flash.now[:alert] = 'この記事(URL)の投稿はできませんでした'
      render :index
      return
    end

    if @post.save
      redirect_to @post, notice: "「#{@post.title}」を登録しました"
    else
      flash.now[:alert] = "記事投稿に失敗しました。#{@post.errors.full_messages[0]}。"
      render :index
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "「#{@post.title}」を削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:url)
  end
end
