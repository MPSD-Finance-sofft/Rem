module ConnectionAres::User

	def downalod_data_from_ares
		return remove_from_ares if self.identity_company_number.blank?

		body = conection_to_ares

		return remove_from_ares if body.blank?

		trades_help = body['Obory_cinnosti']

		return remove_from_ares if trades_help.blank?

		trades = trades_help['Obor_cinnosti']

		return false if self.ares.count == trades.size

		Ares.where(user_id: self.id).delete_all

		trades.each do |trade|
			Ares.create(user_id: self.id, nace: trade["K"], nace_name: trade["T"])
		end
		true
	end

	def remove_from_ares
		Ares.where(user_id: self.id).delete_all
		false
	end

	def change_name_company
		return false if self.identity_company_number.blank?

		body = conection_to_ares

		return false if body.blank?

		company_name = body['OF']

		return false if company_name.blank?

		if self.name_company != company_name
			self.name_company = company_name
			self.save(validate: false)
		else
			false
		end
	end

	def conection_to_ares
		uri = URI.escape("http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_bas.cgi?ico=#{self.identity_company_number}")
		uri = URI.parse(uri)
		res = Net::HTTP.get_response(uri)
		body = Hash.from_xml(res.body)
		body['Ares_odpovedi']['Odpoved']['VBAS']
	end


end