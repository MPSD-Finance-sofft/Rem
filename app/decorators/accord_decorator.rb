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
 				'K podepsání'
 			when 'contract'
 				'Smouva'
 			when 'refuse'
 				'Zamítnutá'
 			when 'dowload'
 				'Stažená'
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
      object.created_at
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
    object.purchase_price.to_s + " Kč"
  end

  def agency_commission_price
    object.agency_commission_price.to_s + " Kč"
  end

  def commission_for_the_contract
    object.commission_for_the_contract.to_s + " Kč"
  end
end
