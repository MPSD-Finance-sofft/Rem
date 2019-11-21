class Notification < ApplicationRecord

	def deactive
		self.active = false 
		self.save
	end

	def object_find
		self.object.constantize.find(self.object_id)
	end

	def self.for_notice_accord(object_id, notice)
		accord = Accord.find(object_id).decorate
		users = []
		users << accord.user_id if accord.user_id != notice.user_id
		users << accord.agent.try(:superior_id) if accord.agent.try(:superior_id) != notice.user_id
		users << accord.last_active_terrains.try(:agent_id) if accord.last_active_terrains.try(:agent_id) != notice.user_id
		users.compact.each do |user_id|
			n = Notification::new_notification_for_accord_notice(object_id, notice,accord)
			n.user_id = user_id
			n.save
		end
	end

	def self.for_notice_leasing_contract(object_id, notice)
		leasing_contract = LeasingContract.find(object_id).decorate
		users = []
		users << leasing_contract.user_id if leasing_contract.user_id != notice.user_id
		users << leasing_contract.accord.agent.try(:superior_id) if leasing_contract.accord.agent.try(:superior_id) != notice.user_id
		users.compact.each do |user_id|
			n = Notification::new_notification_for_leasing_contract_notice(object_id, notice,leasing_contract)
			n.user_id = user_id
			n.save
		end
	end

	def self.for_change_state_accord(accord)
		accord = accord.decorate
		users = []
		users << accord.user_id if accord.user_id != accord.current_user.try(:id)
		users << accord.agent.try(:superior_id) if accord.agent.try(:superior_id) !=  accord.current_user.try(:id)
		users << accord.last_active_terrains.try(:agent_id) if accord.last_active_terrains.try(:agent_id) !=  accord.current_user.try(:id)
		users.compact.each do |user_id|
			n = Notification::new_notification_for_accord_change_state(accord.id,accord)
			n.user_id = user_id
			n.save
		end
	end

	def self.new_notification_for_accord_notice(object_id, notice, accord)
		notification = Notification.new
		notification.object = "Accord"
		notification.object_id = object_id
		notification.text = "Na žádost #{accord.id} ve stavu #{accord.state} klienta #{accord.first_client_full_name} (týkající se nemovitosti #{accord.first_realty_address}) byla přidána poznámka. Tuto poznámku zapsal #{notice.autor} #{notice.created_at}."
		notification.active = true
		notification
	end
	def self.new_notification_for_accord_change_state(object_id, accord)
		notification = Notification.new
		notification.object = "Accord"
		notification.object_id = object_id
		notification.text = "U žádosti #{accord.id} typu #{accord.kind} klienta #{accord.first_client_full_name} (týkající se nemovitosti #{accord.first_realty_address} byla provedena změna stavu na #{accord.state}"
		notification.active = true
		notification
	end

	def self.new_notification_for_leasing_contract_notice(object_id, notice, leasing_contract)
		notification = Notification.new
		notification.object = "LeasingContract"
		notification.object_id = object_id
		notification.text = "Na nájmení smlouvu #{leasing_contract.id} ve stavu #{leasing_contract.state} klienta #{leasing_contract.first_client_full_name} (týkající se nemovitosti #{leasing_contract.first_realty_address} byla přidána poznámka. Tuto poznámku zapsal #{notice.autor} #{notice.created_at}"
		notification.active = true
		notification
	end

	scope :for_user, -> (user_id) {where(user_id:  user_id)}
	scope :active, -> {where(active:  true)}
	scope :active_state, ->(active) {where(active:  active)}
end
