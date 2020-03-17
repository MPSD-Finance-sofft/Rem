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

 	def first_email_to_s
 		object.email.first.try(:email_address)
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

 	def agent_accords_signature_count
 		object.agent_accords_signature.count
 	end

 	def agent_accords_signature
 		format_date object.agent_accords_signature.last.try(:date_of_signature)
 	end

 	def contract_volume_bussines
 		format_number object.contract_volume_bussines
 	end

  	def sum_contract_one_of_payment
 		format_number object.sum_contract_one_of_payment
 	end

  	def contract_volume_servise
 		format_number object.contract_volume_servise
 	end

 	def sum_contract_one_of_payment_service
 		format_number object.sum_contract_one_of_payment_service
 	end

 	def superiors_attribut_changes
 		result = []
 		attribut_changes('superior_id').each do |h|
 			user_first = User.find_by_id(h.second.first).try(:all_name)
 			user_last = User.find_by_id(h.second.last).try(:all_name)
 			result << { date: format_date_time(h.last), creator: User.find_by_id(h.first).try(:all_name), user_first: user_first, user_last: user_last }
 		end
 		result
 	end

  def admin_note_color
    return '#f6b73c' if object.admin_note_color.blank?
    object.admin_note_color
  end

  def manager_note_color
    return '#00FFFF' if object.manager_note_color.blank?
    object.manager_note_color
  end

  def user_note_color
    return '#ff00ff' if object.user_note_color.blank?
    object.user_note_color
  end

  def agent_note_color
    return '#ffff00' if object.agent_note_color.blank?
    object.agent_note_color
  end

  def admin_note_text_color
    return '#000000' if object.admin_note_text_color.blank?
    object.admin_note_text_color
  end

  def manager_note_text_color
    return '#000000' if object.manager_note_text_color.blank?
    object.manager_note_text_color
  end

  def user_note_text_color
    return '#FFFFFF' if object.user_note_text_color.blank?
    object.user_note_text_color
  end

  def agent_note_text_color
    return '#000000' if object.agent_note_text_color.blank?
    object.agent_note_text_color
  end
end
