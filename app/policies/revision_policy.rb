class RevisionPolicy < ApplicationPolicy

	class Scope 
		attr_reader :user, :scope, :accord_id

		def initialize(accord, user, scope)
			@user = user
			@realty_id = accord.realty.first.try(:id)
			@scope = scope
		end

    	def resolve
    		if user.admin? || user.user?
  				scope.for_realty(@realty_id).all 
  			else
  				scope.where("1=2")
  			end
    	end
  	end
end