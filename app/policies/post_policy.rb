class PostPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    record.user == user
  end

  def update?
    false
  end
end
