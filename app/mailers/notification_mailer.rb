# app/mailers/notification_mailer.rb

class NotificationMailer < ApplicationMailer
  helper ApplicationHelper

  def comment_notification(comment)
    @comment = comment
    @post = comment.post
    mail(to: @comment.author.email, subject: "New Comment on Your Post")
  end
end
