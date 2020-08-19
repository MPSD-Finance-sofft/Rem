class LeasingContractPolicy < ApplicationPolicy

  def index?
   !user.agent?
  end

	def show?
        if user.agent? || user.tipster?
            false
        elsif user.manager?
            (record.accord.agent.try(:superior_id) == user.id) || (record.accord.agent_id == user.id) || record.agent_id == user.id
        elsif user.user? || user.admin?
            true
        else
            false
        end
    end

    def update?
        user.user? || user.admin?
    end

    def destroy?
        user.admin?
    end

    def changes?
        update?
    end

    def uploads?
        show?
    end

    def delete_image?
        update?
    end

    class Scope < Scope
        def resolve
            if user.admin? || user.user?
                scope.joins(:accord).includes(:user).includes(:clients).includes(realty: :address).includes(:payments).includes(:repayments)
            elsif user.manager?
                scope.subordinates_accords(user).or(scope.agents_accords(user)).or(scope.agents_in_care(user))
            elsif user.agent? || user.tipster?
                scope.where("1=0")
            end
        end
    end

end
