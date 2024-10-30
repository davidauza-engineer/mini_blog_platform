# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_SENDER"]
  layout "mailer"
end
