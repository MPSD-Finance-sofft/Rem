class ClientPolicy < ApplicationPolicy

    def show?       
          user.user? || user.admin? || user.manager?
  	end
end