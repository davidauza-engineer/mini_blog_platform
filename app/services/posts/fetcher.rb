# frozen_string_literal: true

module Posts
  class Fetcher
    def initialize(query: nil, page: 1, ids: nil, public_api: false)
      @query = query
      @page = page
      @ids = ids.presence&.split(",") || []
      @public_api = public_api
    end

    def call
      if query.present?
        fetch_by_query
      elsif ids.present?
        fetch_by_ids
      elsif public_api
        fetch_public_api
      else
        fetch_default
      end
    end

    private

    attr_reader :query, :page, :ids, :public_api

    def fetch_by_query
      Post.includes(:author)
          .search_by_title_and_body(query)
          .page(page)
    end

    def fetch_by_ids
      Post.includes(:comments)
          .where(id: ids)
          .page(page)
    end

    def fetch_public_api
      Post.includes(:comments).page(page)
    end

    def fetch_default
      Post.includes(:author).page(page)
    end
  end
end
