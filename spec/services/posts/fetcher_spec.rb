# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::Fetcher do
  let(:subject) { described_class.new(query: query, page: page, ids: ids, public_api: public_api) }
  let(:query) { nil }
  let(:page) { 1 }
  let(:ids) { nil }
  let(:public_api) { false }

  describe '#call' do
    context 'when query is present' do
      let(:query) { 'query' }

      it 'calls fetch_by_query' do
        expect_any_instance_of(described_class).to receive(:fetch_by_query)
        subject.call
      end
    end

    context 'when query is not present but ids are present' do
      let(:ids) { '1,2,3' }

      it 'calls fetch_by_ids' do
        expect_any_instance_of(described_class).to receive(:fetch_by_ids)
        subject.call
      end
    end

    context 'when query and ids are not present but public_api is true' do
      let(:public_api) { true }

      it 'calls fetch_public_api' do
        expect_any_instance_of(described_class).to receive(:fetch_public_api)
        subject.call
      end
    end

    context 'when query, ids and public_api are not present' do
      it 'calls fetch_default' do
        expect_any_instance_of(described_class).to receive(:fetch_default)
        subject.call
      end
    end
  end
end
