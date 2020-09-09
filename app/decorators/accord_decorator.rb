class AccordDecorator < ApplicationDecorator
  delegate_all

  	decorates_association :realty
  	decorates_association :notes
  	
  	def object_state
  		object.state
  	end

 	def state
		state_to_text(object.state)
 	end

 	def state_to_text(state)
 		case state
 			when 'state_new'
 				'Nová'
 			when 'state_eleboration'
 				'Rozpracovaná'
 			when 'to_sign'
 				'Ke schválení'
 			when 'contract'
 				'Smlouva'
 			when 'refuse'
 				'Zamítnutá'
 			when 'dowload'
 				'Stažená'
      when 'in_terrain'
        'V terénu'
      when 'returned'
        'Vrácená'
 			else
 			""
 		end
 	end

 	def object_kind
 		object.kind
 	end

 	def kind
		kind_to_text(object.kind)
 	end

 	def select_kind
 		Accord.kinds.keys.map{|a| [kind_to_text(a), a]}
 	end


 	def kind_to_text(kind)
 		case kind
 			when 'buyout'
 					"Výkup"
 			when 'auction'
 					"Dražba"
 			when 'insolvency_buyout'
 					"Insolvenční výkup"
 			else
 					"nedefinovaný typ žádosti"
		end
 	end

 	def select_state
 		Accord.states.keys.map{|a| [state_to_text(a), a]}
 	end

 	def first_client_full_name
		object.clients.first.try(:full_name)
 	end 

  def first_realty_address
    object.realty.first.try(:address).try(:index_name)
  end

 	def created_at
 		format_date(object.created_at)
 	end

  def created_at_time
     format_date_time(object.created_at)
  end
  
 	def creator_name 
 		object.creator.try(:all_name)
 	end

 	def owner_name 
 		object.owner.try(:all_name)
 	end

  def owner_name_tel
    object.owner.try(:mobile).try(:last).try(:phone_number)
  end

  def agent_name
    object.agent.try(:all_name)
  end
  
  def agent_in_signature_name
    object.agent_in_signature.try(:all_name)
  end

  def agent_company
    object.agent.try(:name_company)
  end

  def agent_superior
    object.agent.try(:superior).try(:all_name)
  end

  def agent_bank_code
    object.agent.try(:account_number).to_s + '/' + object.agent.try(:bank_code).to_s
  end

 	def state_to_color(state)
 		case state
 			when 'state_new'
 				'orange'
 			when 'state_eleboration'
 				'lightblue'
 			else
 			""
 		end
 	end

  def agency_commission
    object.agency_commission.to_s + "%"
  end

  def purchase_price
    format_number(object.purchase_price.to_f)
  end
  
  def object_purchase_price
    object.purchase_price
  end

  def repurchase
    format_number(object.repurchase.to_f)
  end

  def object_repurchase
    object.repurchase
  end

  def agency_commission_price
    format_number(object.agency_commission_price.to_f)
  end

  def commission_for_the_contract
    format_number(object.commission_for_the_contract.to_f)
  end

  def date_of_signature
    format_date object.date_of_signature
  end 

  def date_of_ownership
    format_date object.date_of_ownership
  end

  def date_of_transfer
    format_date object.date_of_transfer
  end

  def excepted_date_of_transfer
    format_date object.excepted_date_of_transfer
  end

  def village
    object.realty.first.try(:address).try(:village)
  end

  def reward_created_at
    format_date object.reward.try(:created_at)
  end

  def state_attribut_changes
    result = []
    attribut_changes('state').reverse.each do |h|
      state_first = state_to_text(h.second.first)
      state_last = state_to_text(h.second.last)
      result << { date: format_date_time(h.last), creator: User.find_by_id(h.first).try(:all_name), state_first: state_first, state_last: state_last }
    end
    result
  end

  def all_leasig_contract_payments
    sum = 0
    object.leasing_contracts.each do |lc|
      sum = sum + lc.payments.sum(:amount)
    end
    format_number sum
  end  

  def all_leasig_contract_repayments
    sum = 0
    object.leasing_contracts.each do |lc|
      sum = sum + lc.repayments.sum(:amount)
    end
    format_number sum
  end

  def all_leasig_contract_rent_to_max
    dates = []
    object.leasing_contracts.each do |lc|
      dates << lc.rent_to
    end
    format_date dates.max
  end

  def all_expenses_sum_real_amount
    format_number object.expenses.sum(:real_amount)
  end

  def object_all_leasig_contract_payments
    sum = 0
    object.leasing_contracts.each do |lc|
      sum = sum + lc.payments.sum(:amount)
    end
    sum
  end

  def object_all_leasig_contract_repayments
    sum = 0
    object.leasing_contracts.each do |lc|
      sum = sum + lc.repayments.sum(:amount)
    end
    sum
  end

  def agent_in_terain_name
    object.terrains.active.last.try(:agent).try(:all_name)
  end
end
