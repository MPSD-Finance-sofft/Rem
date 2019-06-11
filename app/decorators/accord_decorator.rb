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
 				'Odmítnuto'
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
 					"nedefinovaný druh klienta"
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

 	def creator_name 
 		object.creator.try(:all_name)
 	end

 	def owner_name 
 		object.creator.try(:all_name)
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

end
