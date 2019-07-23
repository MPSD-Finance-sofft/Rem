class NotePolicy < ApplicationPolicy

	class Scope 
		attr_reader :user, :scope, :accord_id

		def initialize(accord_id, user, scope)
			@user = user
			@accord_id = accord_id
			@scope = scope
		end

    	def resolve
    		if user.admin?
      			scope.for_accord(accord_id).all
    		elsif user.manager?
            	scope.for_accord(accord_id).for_manager
        	elsif user.agent?
        		scope.for_accord(accord_id).for_agent
        	elsif user.user?
            	scope.for_accord(accord_id).all
        	end
    	end
  	end
end