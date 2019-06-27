class InvoiceDecorator < ApplicationDecorator
  delegate_all

  def period
	month_to_czech_text(object.period_month)
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

end
