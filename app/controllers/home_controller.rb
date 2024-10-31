# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Posts::Fetcher.new(query: params[:query], page: params[:page]).call if user_signed_in?
    render layout: "application", template: "home/index"
  end
end
