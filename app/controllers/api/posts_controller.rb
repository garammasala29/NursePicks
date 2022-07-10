# frozen_string_literal: true

class Api::PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments, :user)
  end
end
