# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      protect_from_forgery with: :null_session

      before_action :set_post, only: [ :show, :update, :destroy ]

      # GET /api/v1/posts
      def index
        if params[:ids]
          @posts = Post.where(id: params[:ids].split(","))
        else
          @posts = Post.all
        end
        render json: @posts, include: :comments
      end

      # GET /api/v1/posts/:id
      def show
        render json: @post, include: :comments
      end

      # POST /api/v1/posts
      def create
        @post = Post.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/posts/:id
      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/posts/:id
      def destroy
        @post.destroy
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :body, :author_id)
      end
    end
  end
end
