class ContractsController < ApplicationController
  include ActionView::Helpers::NumberHelper
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
    Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled smlouvy bez smlouvy o prodeji se zpětnou koupí", objet: "without_sales_contract_with_repurchase")
    contract =  Accord.contract.pluck(:id)
    contract_with_sales_contract = Accord.with_sales_contract.pluck(:id)
    @contract_without_sales_contract =  Accord.where(id: contract.reject{|x| contract_with_sales_contract.include?(x)})
    @contract_without_sales_contract = @contract_without_sales_contract.where("repurchase > 0").decorate
    @all_expense = number_to_currency(@contract_without_sales_contract.sum{|a| a.expenses.sum(:real_amount)}, unit: "Kč", separator: ",", delimiter: " ", format: "%n %u",  precision: 0)
    @purchase_price = number_to_currency(@contract_without_sales_contract.sum{|a| a.object_purchase_price}, unit: "Kč", separator: ",", delimiter: " ", format: "%n %u",  precision: 0)
    @repurchase = number_to_currency(@contract_without_sales_contract.sum{|a| a.object_repurchase}, unit: "Kč", separator: ",", delimiter: " ", format: "%n %u",  precision: 0)
    @all_leasig_contract_payments = number_to_currency(@contract_without_sales_contract.sum{|a| a.object_all_leasig_contract_payments}, unit: "Kč", separator: ",", delimiter: " ", format: "%n %u",  precision: 0)
    @all_leasig_contract_repayments = number_to_currency(@contract_without_sales_contract.sum{|a| a.object_all_leasig_contract_repayments}, unit: "Kč", separator: ",", delimiter: " ", format: "%n %u",  precision: 0)
  end
end

