class LeasingContractDecorator < ApplicationDecorator
  delegate_all
	
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

end
