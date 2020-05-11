class OneTimeJobController < ApplicationController

  def task_500710
    contract =  Accord.contract.pluck(:id)
    contract_with_sales_contract = Accord.with_sales_contract.pluck(:id)
    @contract_without_sales_contract =  Accord.where(id: contract.reject{|x| contract_with_sales_contract.include?(x)})
  end


end