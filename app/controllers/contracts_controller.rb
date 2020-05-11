class ContractsController < ApplicationController

	def index
		@accords = policy_scope(Accord).state("contract").order(date_of_signature: :desc)
    @accords =  IndexFilter::IndexServices.new(@accords,params).perform
    @accords = @accords.decorate
    respond_to do |format|
      format.html
      format.json
  	end
	end

  def without_sales_contract
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" unless current_user.admin?
    Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled smlouvy bez smlouvy o prodeji", objet: "task_500710")
    contract =  Accord.contract.pluck(:id)
    contract_with_sales_contract = Accord.with_sales_contract.pluck(:id)
    @contract_without_sales_contract =  Accord.where(id: contract.reject{|x| contract_with_sales_contract.include?(x)})
    @contract_without_sales_contract = @contract_without_sales_contract.where("repurchase > 0")
  end
end

