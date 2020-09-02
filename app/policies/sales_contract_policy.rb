class SalesContractPolicy < ApplicationPolicy

  def index?
   user.user_or_admin?
  end

  def show?
    user.user_or_admin?
  end

  def update?
    user.user_or_admin?
  end

  def destroy?
    user.user_or_admin?
  end

  def report?
    user.user_or_admin?
  end
end
