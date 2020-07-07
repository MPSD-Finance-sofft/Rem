class AccordValidator < ActiveModel::Validator

	def validate(record)
		max_agency_commission(record)
    check_agency_commission(record)
		state(record)
		kind(record)
		purchase_price(record)
		agent_id(record)
		accords_clients(record)
		accords_realty(record)
	end

	def max_agency_commission(record)
		record.errors.add(:agency_commission, "Maximální výše provize je 5%") if record.agency_commission.to_f > 5
	end

  def check_agency_commission(record)
    record.errors.add(:agency_commission, "Tipař nemuže mít zprostředkovatelkou provizi")  if record.agent.try(:tipster?) && record.agency_commission.to_f != 0
  end

	def state(record)
		record.errors.add(:state, "Stav je povinný") if record.state.blank?
	end

	def kind(record)
		record.errors.add(:kind, "Typ žádosti je povinný") if record.kind.blank?
	end

	def purchase_price(record)
		record.errors.add(:purchase_price, "Výkupní cena nesmí být menší než 0") if record.purchase_price.to_f <= 0
	end

	def agent_id(record)
		record.errors.add(:agent_id, "Pokud máte roli agent, agent nesmí být prázdný") if !record.current_user.blank? &&record.current_user.agent? && record.agent_id.blank?
	end

	def accords_clients(record)
		record.errors.add(:accords_clients, "Klient musí být vyplněn") if record.accords_clients.blank?
	end

	def accords_realty(record)
		record.errors.add(:accords_realty, "Nemovitost musí být vyplněna") if record.accords_realty.blank?
	end


end