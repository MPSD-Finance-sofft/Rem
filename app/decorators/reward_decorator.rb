class RewardDecorator < ApplicationDecorator
  delegate_all

  def accord
  	object.accord.try(:id)
  end

  def agent
  	object.agent.try(:all_name)
  end

  def agency_commission
  	object.agency_commission.to_s + " Kč"
  end 

  def commission_for_the_contract
  	object.commission_for_the_contract.to_s + " Kč"
  end


end
