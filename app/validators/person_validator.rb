class PersonValidator < ActiveModel::Validator

	def validate(record)
		name(record)
		last_name(record)
	end

	def name(record)
		record.errors.add(:name, "Jméno je povinný") if record.name.blank?
	end

	def last_name(record)
		record.errors.add(:last_name, "Přijmení je povinný") if record.last_name.blank?
	end
end