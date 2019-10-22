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

 	def select_realationship
 		[['neuvádí se', nil], ['Druh,Družka', 'companion'],['Rozvedený/á', 'divorced'], ['Svobodný/á', 'free'], ['Vdovec/a', 'widow'], ['Chudák/Vdaná', 'married']]
 	end

 	def realationship_text(relation_ship)
 		case relation_ship
 			when nil, ""
				"neuvádí se"
 			when 'companion'
 				'Druh,Družka'
 			when 'divorced'
 				'Rozvedený/á'
 			when 'free'
 				'Svobodný/á'
 			when 'widow'
 				'Vdovec/a'
 			when 'married'
 				'Chudák/Vdaná'
 			else
				"nedefinovaný druh klienta"
		end
 	end

 	def relation_ship
 		realationship_text(object.relation_ship)
 	end
 	
 	def object_relation_ship
 		object.relation_ship
 	end
end