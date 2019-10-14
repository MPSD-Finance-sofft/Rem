class ContractPolicy < ApplicationPolicy
	def index?
		 user.admin? || user.user?
	end
end