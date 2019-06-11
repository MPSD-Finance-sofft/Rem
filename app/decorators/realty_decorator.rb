class RealtyDecorator < Draper::Decorator
  delegate_all

	def type_ownership
		type_ownership_to_text(object.type_ownership)
 	end

 	def select_type_ownership
 		Realty.type_ownerships.keys.map{|a| [type_ownership_to_text(a), a]}
 	end


 	def type_ownership_to_text(type_ownership)
 		case type_ownership
 			when 'part'
 					"Podílné"
 			when 'exclusiv'
 					"Výlučné"
 			when 'sjm'
 					"SJM"
 			else
 					"nedefinovaný typ vlastnictví"
		end
 	end

 	def realty_type
 		object.realty_type.try(:name)
 	end

 	def address_village
 		object.address.try(:village)
 	end
 	def address_street
 		object.address.try(:street)
 	end
	def address_number
 		object.address.try(:number)
 	end

 	
end