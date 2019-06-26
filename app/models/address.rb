class Address < ApplicationRecord
	before_save :completion

	def completion
		address = AutocompleterAddress::validate_adres(self.village,self.street,self.number.split("/").first)
		if address 
			self.zip = address['psc']
			self.district = address['okres']
			self.region = address['kraj']
			self.state = "Čr"
		end
	end

	def full_name
		"#{self.village.to_s} #{self.street.to_s}  #{self.number.to_s} #{self.zip.to_s}  #{self.district.to_s} #{self.region.to_s} #{self.state.to_s}" 
	end
	
	def table_name
		"#{self.village.to_s} #{self.street.to_s} #{self.number.to_s}" 
	end
end
