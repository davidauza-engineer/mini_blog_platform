# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rate Limiting', type: :request do
  context 'when making too many requests' do
    before do
      Rack::Attack.enabled = true
    end

    after do
      Rack:: Attack.enabled = false
    end

    it 'throttles excessive requests' do
      60.times do
        get '/api/v1/posts'
        expect(response).not_to have_http_status(429)
      end

      get '/api/v1/posts'
      expect(response).to have_http_status(429)
    end
  end
end
