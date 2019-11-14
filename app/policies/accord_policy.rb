class AccordPolicy < ApplicationPolicy

    def show?       
        if user.agent?
            (record.agent_id == user.id)
        elsif user.manager?
            (record.agent.try(:superior_id) == user.id) 
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

    def uploads?
        show?
    end

    def delete_image?
        update?
    end
    
	class Scope < Scope
   
    	def resolve
    		if user.admin? || user.user?
      			scope.includes(:owner).includes(realty: :address).includes(agent: :superior).includes(:clients)
    		elsif user.manager?
            	scope.subordinates_accords(user)
        	elsif user.agent?
        		scope.agents_accords(user)
        	end
    	end
  	end
end