class UserPolicy < ApplicationPolicy
	def index?
    true
  end

  def update?
    user.admin? || user.user?
  end


 	class Scope < Scope
   
    	def resolve
    		if user.admin?
      			scope.all
      		elsif user.agent?
            scope.subordinates(user)
          end
    	end
  end

end