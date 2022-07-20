# frozen_string_literal: true

class Api::PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments, :likes).sort { |a, b| b.likes.size <=> a.likes.size }
  end
end
