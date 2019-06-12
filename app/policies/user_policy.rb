class UserPolicy < ApplicationPolicy
	
	def index?
		@record = nil
		user.admin?
	end

	 def update?
    	false
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