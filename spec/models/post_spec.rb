# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:author).class_name('User') }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
