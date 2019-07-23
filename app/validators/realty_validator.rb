class RealtyValidator < ActiveModel::Validator

	def validate(record)
		realty_type(record)
		address(record)
	end

	def realty_type(record)
		record.errors.add(:realty_type, "Typ nemovitosti je povinný") if record.realty_type.blank?
	end

	def address(record)
		record.errors.add(:address, "Adresa je povinný") if record.address.blank?
	end

end