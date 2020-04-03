class PaymentPolicy < ApplicationPolicy
  def index?
    user.user_or_admin?
  end
end