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
      			scope.all.order(username: :desc)
    		elsif user.agent? || user.manager?
            scope.subordinates(user).order(username: :desc)
        elsif user.user?
            scope.all.order(username: :desc)
        end
    	end
  end

end