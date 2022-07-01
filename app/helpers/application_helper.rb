# frozen_string_literal: true

module ApplicationHelper
  def page_category
    "#{params[:controller]}-#{params[:action]}"
  end
end
