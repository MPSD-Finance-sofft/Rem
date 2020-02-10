module Reports::User

	def agent_contracts_bussines
		accord_for_user_in_interval.state("contract")
	end

	def accord_for_user_in_interval
		Accord.agent_id(User.subordinates(self).pluck(:id) << id)
	end

	def accord_for_user_in_interval_in_signature
		Accord.agent_signature(User.subordinates(self).pluck(:id) << id)
	end

	def contract_volume_bussines
		agent_contracts_bussines.sum(:purchase_price)
	end

	def count_contract_bussines
		agent_contracts_bussines.count
	end

	def sum_contract_one_of_payment
		agent_contracts_bussines.joins(:commitments).where('commitments.commitment_type_id': [4,5,6]).sum(:amount)
	end

	def events_for_the_period
		Event.for_user(id).count
	end

	def events_meeting_with_advisors
		Event.for_user(id).where(title: ['Servisní návštěva', 'Akviziční schůzka']).count
	end

	def count_accord_for_user_in_interval
		Accord.agent_id(User.subordinates(self).pluck(:id) << id).count
	end

	def count_accord_to_terrain
		accord_for_user_in_interval.agent_in_terrain([User.subordinates(self).pluck(:id) << id]).count
	end

	def count_new_cooperation
		User.subordinates(self).count
	end

	def count_not_termination_cooperation
		User.can_sign_in.subordinates(self).select(&:not_runing_notice?).size
	end

	def count_active_cooperation
		User.can_sign_in.subordinates(self).select(&:date_of_last_create_accord_smaller_then_60?).size
	end

	def count_not_termination_incomplate_cooperation
		User.can_sign_in.subordinates(self).select(&:not_runing_notice?).select(&:complate_documentation?).size
	end

	def contract_volume_servise
		accord_for_user_in_interval_in_signature.sum(:purchase_price)
	end

	def count_contract_servise
		accord_for_user_in_interval_in_signature.count
	end

	def sum_contract_one_of_payment_service
		accord_for_user_in_interval_in_signature.joins(:commitments).where('commitments.commitment_type_id': [4,5,6]).sum(:amount)
	end

	def count_active_state
		Accord.where(agent_id: accord_for_user_in_interval.pluck(:id)).select(&:active_state_between_date?)
	end
end