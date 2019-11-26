class InvoiceDecorator < ApplicationDecorator
  delegate_all

  def period
    month_to_czech_text(object.period_month) + ' ' + object.period_year.to_s
  end

  def agency_commission
  	format_number object.rewards.pluck(:agency_commission).sum
  end

  def commission_for_the_contract
  	format_number object.rewards.pluck(:commission_for_the_contract).sum
  end

  def agent
  		object.rewards.first.try(:agent).try(:all_name)
  end

  def agent_superior
    object.rewards.first.try(:agent).try(:superior).try(:all_name)
  end

  def excepted_payment_day
      format_date(object.created_at + 21.day)
  end

   def agent_company
    object.agent.try(:name_company)
  end

  def agent_identity_company_number
    object.agent.try(:identity_company_number)
  end

  def agnet_bank_number
     object.agent.try(:account_number).to_s + " / " +  object.agent.try(:bank_code).to_s
  end

  def purchase_price
    format_number object.rewards.sum(&:purchase_price)
  end

  def payout_date
    format_date object.payout_date
  end

  def delivery_date
    format_date object.delivery_date
  end

  def variable
    object.agent.username.match('[\d]\w+').to_s
  end

  def agent_user_name
    object.agent.username
  end

  def agent_address
    object.user_address.where(kind: 'billing').first.address.index_name
  end

end
