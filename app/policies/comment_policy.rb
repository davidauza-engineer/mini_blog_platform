# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def update?
    destroy?
  end

  def destroy?
    user.author? && record.author == user
  end
end
