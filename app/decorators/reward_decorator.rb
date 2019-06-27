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

  def agent_login
    object.agent.try(:username)
  end

  def payment_date
      format_date(object.created_at + 21.day)
  end

  def agent_company
    object.agent.try(:name_company)
  end

  def agent_identity_company_number
    object.agent.try(:identity_company_number)
  end


end
