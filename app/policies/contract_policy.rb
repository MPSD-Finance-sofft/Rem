class ContractPolicy < ApplicationPolicy
	class Scope < Scope
   
    	def resolve
    		if user.admin? || user.user?
      			scope.state("contract").includes(:owner).includes(realty: :address).includes(agent: :superior).includes(:clients)
    		elsif user.manager?
            	scope.state("contract").subordinates_accords(user)
        	elsif user.agent?
        		scope.state("contract").agents_accords(user)
        	end
    	end
  	end
end