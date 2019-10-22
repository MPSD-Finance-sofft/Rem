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

 	def object_type_ownership
 		object.type_ownership
 	end

 	def record_on_lv
		record_on_lv_to_text(object.record_on_lv)
 	end

 	def select_record_on_lv
 		Realty.record_on_lvs.keys.map{|a| [record_on_lv_to_text(a), a]}
 	end


 	def record_on_lv_to_text(record_on_lv)
 		case record_on_lv
 			when 'burden'
 					"Břemeno"
 			when 'execution'
 					"Exekuce"
 			when 'hypothec'
 					"Hypotéka"
 			when 'insolvency_manager'
 					"Insolvenční manager"
 			when 'unknown'
 					"Neznámý"
 			when 'pledge'
 					"Zástava"
 			else
 					"nedefinovaný typ záznamu na lv"
		end
 	end

 	def object_record_on_lv
 		object.record_on_lv
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


 	def location_to_text(location)
 		case location
 			when 'county_seat'
 					"Krajské město"
 			when 'discrit_town'
 					"Okresní město"
 			when 'country_seat_15_km'
 					"15 km do okresní města"
 			when 'district_town_15_km'
 					"15 km od okresního města"
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

 	
end