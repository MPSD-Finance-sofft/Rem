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
 				'Nový'
 			when 'state_eleboration'
 				'Rozpracováno'
 			when 'to_sign'
 				'Ke schválení'
 			when 'contract'
 				'Smlouva'
 			when 'refuse'
 				'Zamítnutá'
 			when 'dowload'
 				'Stažená'
      when 'in_terrain'
        'v terénu'
 			else
 			"nedefinovaný stav"
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

  def agent_name
    object.agent.try(:all_name)
  end

  def agent_company
    object.agent.try(:name_company)
  end

  def agent_superior
    object.agent.try(:superior).try(:all_name)
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
  
  def repurchase
    format_number(object.repurchase.to_f)
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

  def village
    object.realty.first.try(:address).try(:village)
  end
end
