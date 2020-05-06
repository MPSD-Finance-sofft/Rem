class RewardPolicy < ApplicationPolicy

    def show?       
        if user.agent? || user.tipster?
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
        user.user? || user.admin?
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
        	elsif user.agent? || user.tipster?
        		scope.for_user(user)
        	end
    	end
  	end
end