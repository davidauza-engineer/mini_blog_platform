# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentNotificationJob, type: :job do
  let(:comment) { create(:comment) }

  describe '#perform' do
    it 'enqueues the job' do
      expect {
        CommentNotificationJob.perform_async(comment.id)
      }.to change(CommentNotificationJob.jobs, :size).by(1)
    end

    it 'executes perform' do
      expect(NotificationMailer).to receive(:comment_notification).with(comment).and_call_original
      CommentNotificationJob.new.perform(comment.id)
    end
  end
end
