# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]
  before_action :signin_required, only: %i[create destroy]

  def index
    @post = Post.new
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def create
    @post = current_user.posts.new(post_params) do |post|
      page = MetaInspector.new(post.url)
      if page
        post.title = page.title
        post.image_url = page.meta['og:image'] || 'logo_picks.png'
        post.site_name = page.meta['og:site_name']
      end
    end

    if @post.save
      redirect_to @post, notice: "「#{@post.title}」を登録しました"
    else
      flash[:alert] = '記事投稿に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: '記事を削除しました'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:url)
  end

  def signin_required
    redirect_to root_path unless current_user
  end
end
