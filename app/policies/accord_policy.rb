class AccordPolicy < ApplicationPolicy

    def show?
        !(record.contract? && (user.agent? || user.manager?))
    end

    def update?
        user.user? || user.admin?
    end

    def destroy? 
        user.admin?
    end

    def changes?
        update?
    end
    
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