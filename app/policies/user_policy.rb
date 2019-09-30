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
      			scope.all
    		elsif user.agent? || user.manager?
            scope.subordinates(user)
        elsif user.user?
            scope.agents
        end
    	end
  end

end