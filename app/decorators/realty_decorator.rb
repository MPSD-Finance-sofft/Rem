class RealtyDecorator < ApplicationDecorator
  delegate_all

	def type_ownership
		type_ownership_to_text(object.type_ownership)
 	end

 	def select_type_ownership
 		Realty.type_ownerships.keys.map{|a| [type_ownership_to_text(a), a]}
 	end


 	def type_ownership_to_text(type_ownership)
 		case type_ownership
 			when nil
 				''
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

 	def object_type_ownership
 		object.type_ownership
 	end

 	def location
		location_to_text(object.location)
 	end

 	def object_location
		object.location
 	end

 	def select_location
 		Realty.locations.keys.map{|a| [location_to_text(a), a]}
 	end

 	def record_on_lvs
 		object.record_on_lvs.map{|a| a.kind_to_s}.join(",")
 	end


 	def location_to_text(location)
 		case location
 			when 'county_seat'
 					"Krajské město"
 			when 'discrit_town'
 					"Okresní město"
 			when 'country_seat_15_km'
 					"Do 15km od okresního města"
 			when 'district_town_15_km'
 					"Nad 15km od okresního města"
 			else
 					"nedefinovaný typ lokality"
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

 	def address_fullname
 		object.address.try(:full_name)
 	end

 	def date_of_final_building_approval
 		format_date object.date_of_final_building_approval
 	end




 	
end