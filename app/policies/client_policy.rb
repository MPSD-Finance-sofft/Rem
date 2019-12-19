class ClientPolicy < ApplicationPolicy

    def show?       
          user.user? || user.admin?
  	end
end