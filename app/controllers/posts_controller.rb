# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    @post = Post.create(post_params)
    page = MetaInspector.new(@post.url)

    @post.title = page.title
    @post.image_url = page.meta['og:image'] || "http://www.google.com/s2/favicons?domain=#{@post.url}"
    @post.site_name = page.meta['og:site_name']
    @post.user_id = 1

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:url)
  end
end
