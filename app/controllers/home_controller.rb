# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.all if user_signed_in?
    render layout: "application", template: "home/index"
  end
end
