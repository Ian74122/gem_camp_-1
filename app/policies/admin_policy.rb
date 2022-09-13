class AdminPolicy < ApplicationPolicy
  def check_admin?
    record.admin?
  end
end
