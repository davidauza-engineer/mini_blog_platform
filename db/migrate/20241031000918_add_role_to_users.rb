# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role, :string, default: 'guest'
  end
end
