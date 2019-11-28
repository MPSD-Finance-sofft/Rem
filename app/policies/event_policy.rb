class EventPolicy < ApplicationPolicy

	class Scope 
		attr_reader :user, :scope

		def initialize(user, scope)
			@user = user
			@scope = scope
		end

    	def resolve
    		if user.admin? || user.user?
  				scope.all 
  			elsif user.manager?
            	scope.subordinates_events(user).or(scope.for_user(user))
  			elsif user.agent?
        		scope.for_user(user.id)
  			end
    	end
  	end
end