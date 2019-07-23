class PersonValidator < ActiveModel::Validator

	def validate(record)
		name(record)
		last_name(record)
		mobil(record)
	end

	def name(record)
		record.errors.add(:name, "Jméno je povinný") if record.name.blank?
	end

	def last_name(record)
		record.errors.add(:last_name, "Přijmení je povinný") if record.last_name.blank?
	end

	def mobil(record)
		record.errors.add(:mobil, "Mobil je povinný") if record.mobil.blank?
	end
end