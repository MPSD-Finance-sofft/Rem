class AccordPolicy < ApplicationPolicy

	class Scope < Scope
   
    	def resolve
    		if user.admin?
      			scope.all
    		elsif user.manager?
            	scope.subordinates_accords(user)
        	elsif user.agent?
        		scope.agents_accords(user)
        	elsif user.user?
            	scope.all
        	end
    	end
  	end
end