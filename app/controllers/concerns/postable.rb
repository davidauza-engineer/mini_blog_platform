# frozen_string_literal: true

module Postable
  extend ActiveSupport::Concern

  private

  def set_post
    @post = Post.includes(:author).find(params[:id])
  end

  def authorize_user!
    authorize @post
  end
end
