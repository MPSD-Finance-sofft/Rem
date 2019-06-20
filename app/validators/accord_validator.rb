class AccordValidator < ActiveModel::Validator

	def validate(record)
		max_agency_commission(record)
	end

	def max_agency_commission(record)
		record.errors.add(:agency_commission, "Maximální výše provize je 5%") if record.agency_commission > 5
	end
end