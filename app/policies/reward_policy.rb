class RewardPolicy < ApplicationPolicy

    def show?       
        if user.agent?
            (record.user_id == user.id)
        elsif user.manager?
            (record.user.try(:superior_id) == user.id) || (record.user_id == user.id)
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
      			scope.all
    		elsif user.manager?
            	scope.subordinates_rewards(user).or(scope.for_user(user))
        	elsif user.agent?
        		scope.for_user(user)
        	end
    	end
  	end
end