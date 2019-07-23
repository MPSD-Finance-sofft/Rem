class ExpensePolicy < ApplicationPolicy

	class Scope 
		attr_reader :user, :scope, :accord_id

		def initialize(accord_id, user, scope)
			@user = user
			@accord_id = accord_id
			@scope = scope
		end

    	def resolve
    		if user.admin? || user.user?
  				scope.for_accord(accord_id).all 
  			else
  				scope.where("1=2")
  			end
    	end
  	end
end