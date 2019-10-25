class UserPolicy < ApplicationPolicy
	def index?
    true
  end

  def update?
    user.admin? || user.user?
  end

  def edit?
    update?
  end

  def new_user?
    update?
  end

 	class Scope < Scope
   
    	def resolve
    		if user.admin?
      			scope.all.order(created_at: :desc)
    		elsif user.agent? || user.manager?
            scope.subordinates(user).order(created_at: :desc)
        elsif user.user?
            scope.all.order(created_at: :desc)
        end
    	end
  end

end