class EventPolicy < ApplicationPolicy

	def all_list?
		user.admin? || user.user?
	end

	class Scope 
		attr_reader :user, :scope

		def initialize(user, scope)
			@user = user
			@scope = scope
		end

    	def resolve
    		if user.admin? || user.user?
  				scope.all 
  			else
  				scope.where("1=2")
  			end
    	end
  	end
end