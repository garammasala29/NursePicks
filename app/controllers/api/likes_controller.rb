# frozen_string_literal: true

class API::LikesController < ApplicationController
  def create
    @like = current_user.likes.create!(post_id: params[:post_id])
    render status: :created, json: @like
  end

  def destroy
    current_user.likes.find(params[:id]).destroy!
    head :no_content
  end
end
