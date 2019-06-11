class ClientDecorator < ApplicationDecorator
  delegate_all
  
	def kind
		kind_to_text(object.kind)
 	end

 	def select_kind
 		Client.kinds.keys.map{|a| [kind_to_text(a), a]}
 	end


 	def kind_to_text(kind)
 		case kind
 			when 'person'
 					"Osoba"
 			when 'company'
 					"Společnost"
 			else
 					"nedefinovaný druh klienta"
		end
 	end
end