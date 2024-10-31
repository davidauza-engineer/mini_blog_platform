# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      CommentNotificationJob.perform_async(@comment.id)
      redirect_to @post, notice: "Comment was successfully created."
    else
      redirect_to @post, alert: "Error creating comment."
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully destroyed."
  end

  private

  def set_post
    @post = Post.includes(:author, :comments).find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def authorize_user!
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
