class LeasingContractDecorator < ApplicationDecorator
  	delegate_all
  	decorates_association :repayment

	def object_state
  		object.state
  	end

 	def state
		state_to_text(object.state)
 	end

 	def state_to_text(state)
 		case state
 			when 'entry'
 				'k podpisu'
 			when 'action'
 				'Aktivní'
 			when 'debt'
 				'Dluh'
 			when 'added'
 				'Doplaceno'
 			when 'ended'
 				'Ukončeno'
 			else
 			"nedefinovaný stav"
 		end
 	end

	def select_state
 		LeasingContract.states.keys.map{|a| [state_to_text(a), a]}
 	end


 	def rent_from
 		format_date(object.rent_from)
 	end

 	def rent_to
 		format_date(object.rent_to)
 	end
 	
 	def expected_date_of_signature
 		format_date(object.expected_date_of_signature)
 	end

 	def first_client_full_name
		object.clients.first.try(:full_name)
 	end
end
