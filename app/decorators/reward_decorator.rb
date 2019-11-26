class RewardDecorator < ApplicationDecorator
  delegate_all

  def accord
  	object.accord.try(:id)
  end

  def agent
  	object.agent.try(:all_name)
  end

  def commission_for_the_contract
  	format_number object.commission_for_the_contract
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

  def agent_superior
    object.agent.try(:superior).try(:all_name)
  end

  def contract
    object.accord.try(:contract_number)
  end

  def invoice_date
    format_date object.invoice_date
  end
  
  def claim_date
    format_date object.claim_date
  end

  def purchase_price
    format_number object.purchase_price
  end

  def agency_commission
    format_number object.agency_commission
  end

  def first_client
    object.accord.try(:clients).try(:first).try(:full_name)
  end

  def object_accord
    object.accord
  end

end
