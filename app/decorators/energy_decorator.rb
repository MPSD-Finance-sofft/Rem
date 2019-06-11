class EnergyDecorator < ApplicationDecorator
  delegate_all

  	def object_kind
  		object.kind
  	end
	
	def kind
		kind_to_text(object.kind)
 	end

 	def select_kind_energy
 		Energy.kinds.keys.map{|a| [kind_to_text(a), a]}
 	end


 	def kind_to_text(kind)
 		case kind
 			when 'electricity'
 					"Elektřina"
 			when 'gas'
 					"Plyn"
 			when 'water'
 					"Voda"
 			else
 					"nedefinovaný typ vlastnictví"
		end
 	end

 	def distributor
 		object.distributor.try(:name)
 	end

end
