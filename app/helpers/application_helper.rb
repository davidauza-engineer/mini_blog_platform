# frozen_string_literal: true

module ApplicationHelper
  def author_of(resource)
    author = resource.author
    author.name || author.email
  end
end
