# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if user_signed_in? && params[:query].present?
      @posts = Post.includes(:author, :comments)
                   .search_by_title_and_body(params[:query])
                   .page(params[:page])
    else
      @posts = Post.includes(:author, :comments).page(params[:page])
    end
    render layout: "application", template: "home/index"
  end
end
