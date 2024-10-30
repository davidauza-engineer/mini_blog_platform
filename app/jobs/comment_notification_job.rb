# frozen_string_literal: true

class CommentNotificationJob
  include Sidekiq::Job

  queue_as :default

  def perform(comment_id)
    comment = Comment.find(comment_id)
    NotificationMailer.comment_notification(comment).deliver_now
  end
end
