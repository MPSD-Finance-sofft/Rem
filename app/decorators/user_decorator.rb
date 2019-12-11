class UserDecorator < ApplicationDecorator
  delegate_all

 	def permission_to_s
 		object.permission.try(:kind)
 	end

 	def superior
 		object.superior.try(:all_name)
 	end

 	def object_superior
 		object.superior
 	end

 	def date_of_cooperation
 		format_date(object.date_of_cooperation)
 	end
 	
 	def birthdate
 		format_date(object.birthdate)
 	end

 	def date_of_cooperation
 		format_date(object.date_of_cooperation)
 	end
 	
 	def date_of_last_create_accord
 		format_date(object.date_of_last_create_accord)
 	end

 	def date_of_last_contract
 		format_date(object.date_of_last_contract)
 	end

 	def  full_bank_code
 		object.try(:account_number).to_s + '/' + object.try(:bank_code).to_s
 	end

 	def mobile_to_s
 		object.mobile.map{|a| a.phone_number}.join(" ")
 	end

 	def email_to_s
 		object.email.map{|a| a.email_address}.join(" ")
 	end

 	def billing_address_to_s
 		object.user_address.where(kind: 'billing').first.try(:address).try(:index_name)
 	end

 	def billing_address_district_to_s
 		object.user_address.where(kind: 'billing').first.try(:address).try(:district)
 	end

 	def mailing_address_to_s
 		object.user_address.where(kind: 'mailing').first.try(:address).try(:index_name)
 	end

 	def mailing_address_district_to_s
 		object.user_address.where(kind: 'mailing').first.try(:address).try(:district)
 	end	

 	def permanent_address_to_s
 		object.user_address.where(kind: 'permanent').first.try(:address).try(:index_name)
 	end

 	def permanent_address_district_to_s
 		object.user_address.where(kind: 'permanent').first.try(:address).try(:district)
 	end

 	def terrain_count
 		object.terrains.count
 	end

 	def last_terrain
 		format_date object.terrains.last.try(:date_to_terrain)
 	end

 	def accord_terrain_in_agent_count
 		object.agent_accords.joins(:terrains).distinct.count
 	end

 	def accord_terrain_in_agent
 		format_date object.agent_accords.joins(:terrains).last.try(:last_terrains).try(:date_to_terrain)
 	end
end
