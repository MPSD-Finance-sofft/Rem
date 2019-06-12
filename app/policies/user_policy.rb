class UserPolicy < ApplicationPolicy
	
	def index?
		user.admin?
	end

  def update?
    user.admin? || user.user?
  end

 	class Scope < Scope
   
    	def resolve
    		if user.admin?
      			scope.all
      		else
            scope.where("1!=1")
          end
    	end
  end

end