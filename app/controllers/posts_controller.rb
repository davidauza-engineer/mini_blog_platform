# frozen_string_literal: true

class PostsController < ApplicationController
  include Postable

  before_action :authenticate_user!
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:author).page(params[:page])
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      current_user.update(role: "author") unless current_user.author?
      redirect_to @post, notice: "Post was successfully created."
    else
      redirect_to new_post_path, alert: "Error creating post."
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url, notice: "Post was successfully destroyed."
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
