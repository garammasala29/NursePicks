# frozen_string_literal: true

class Api::CommentsController < ApplicationController
  def destroy
    current_user.comments.find(params[:id]).destroy!
    head :no_content
  end
end
