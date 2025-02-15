# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :post, foreign_key: true, null: false
      t.references :author, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
