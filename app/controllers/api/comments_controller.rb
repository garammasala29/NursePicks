# frozen_string_literal: true

class API::CommentsController < ApplicationController
  before_action :require_signin

  def destroy
    current_user.comments.find(params[:id]).destroy!
    head :no_content
  end
end
