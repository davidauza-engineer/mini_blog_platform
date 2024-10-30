# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if user_signed_in? && params[:query].present?
      @posts = Post.search_by_title_and_body(params[:query])
    else
      @posts = Post.all
    end
    render layout: "application", template: "home/index"
  end
end
