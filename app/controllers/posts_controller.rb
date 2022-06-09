# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]
  before_action :signin_required, only: %i[new create destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    @post = current_user.posts.create(post_params)
    page = MetaInspector.new(@post.url)

    @post.title = page.title
    @post.image_url = page.meta['og:image'] || "http://www.google.com/s2/favicons?domain=#{@post.url}"
    @post.site_name = page.meta['og:site_name']

    if @post.save
      redirect_to @post, notice: "「#{@post.title}」を登録しました"
    else
      render :new
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
