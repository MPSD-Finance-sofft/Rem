class NotePolicy < ApplicationPolicy
        

        def destroy? 
            return true if user.admin?
            record.user_id == user.id
        end


	class Scope 
		attr_reader :user, :scope, :accord_id

		def initialize(accord_id, user, scope)
			@user = user
			@accord_id = accord_id
			@scope = scope
		end

    	def resolve
    		if user.admin?
      			scope.order(created_at: :desc).for_accord(accord_id).all
    		elsif user.manager?
            	scope.order(created_at: :desc).for_accord(accord_id).for_manager
        	elsif user.agent? || user.tipster?
        		scope.order(created_at: :desc).for_accord(accord_id).for_agent
        	elsif user.user?
            	scope.order(created_at: :desc).for_accord(accord_id).all
        	end
    	end
  	end
end