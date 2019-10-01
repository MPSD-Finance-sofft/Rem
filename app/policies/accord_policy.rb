class AccordPolicy < ApplicationPolicy

    def show?       
        if user.agent?
            (record.agent_id == user.id)  && !record.contract?
        elsif user.manager?
            (record.agent.try(:superior_id) == user.id || record.agent_terrain_id == user.id) && !record.contract?
        elsif user.user? || user.admin?
            true
        else
            false
        end
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
            	scope.subordinates_accords(user).or(scope.agent_terrain(user))
        	elsif user.agent?
        		scope.agents_accords(user)
        	elsif user.user?
            	scope.all
        	end
    	end
  	end
end