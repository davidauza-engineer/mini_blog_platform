# frozen_string_literal: true

class AddIndexesToPostsTitleAndBody < ActiveRecord::Migration[7.2]
  def change
    add_index :posts, :title
    add_index :posts, :body
  end
end
