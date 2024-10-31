# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def update?
    destroy?
  end

  def destroy?
    user.author? && record.author == user
  end
end
