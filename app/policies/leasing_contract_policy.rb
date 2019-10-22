class LeasingContractPolicy < ApplicationPolicy
	
	def index?
		user.user? || user.admin? 
	end

    def show?       
 		 user.user? || user.admin?      
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
    
end