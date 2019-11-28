class UserPolicy < ApplicationPolicy
	def index?
    true
  end

  def update?
    user.admin? || user.user? || record.id == user.id
  end

  def edit?
    update?
  end

  def new_user?
    update?
  end
  
  def card?
    update?
  end
  
  def changes?
    update?
  end

 	class Scope < Scope
   
    	def resolve
    		if user.admin?
      			scope.includes(:superior).includes(:agent_accords).joins(:permission).order(username: :desc)
    		elsif user.agent? || user.manager?
            scope.subordinates(user).or(scope.id(user)).order(username: :desc)
        elsif user.user?
            scope.all_without_user.order(username: :desc)
        end
    	end
  end

end