class LeasingContractDecorator < ApplicationDecorator
  	delegate_all
  	decorates_association :repayment
  	decorates_association :realty

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
 			when 'actions'
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

	def village
		object.realty.first.try(:address).try(:village)
	end

	def monthly_rent
		format_number object.monthly_rent
	end

	def payments_sum
		format_number object.payments.sum(:amount)
	end
	def repayments_sum
		format_number object.repayments.sum(:amount)
	end

	def address
		object.realty.first.try(:address).try(:index_name)
	end

	def object_kind
 		object.kind
 	end

 	def kind
		kind_to_text(object.kind)
 	end

 	def select_kind
 		LeasingContract.kinds.keys.map{|a| [kind_to_text(a), a]}
 	end


 	def kind_to_text(kind)
 		case kind
 			when 'long'
 				'Dlouhodobá'
 			when 'from_reality'
 				'Přes FR'
 			when 'prepaid'
 				'Předplacená'
 			else
 				""
		end
 	end
end
