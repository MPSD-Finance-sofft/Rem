class ClientDecorator < ApplicationDecorator
  delegate_all
  
	def select_kind
 		[['Osoba', 'Person'],['Společnost', 'Company']]
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