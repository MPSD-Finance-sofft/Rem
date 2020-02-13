module ConnectionAres::User

	def downalod_data_from_ares

		return remove_from_ares if self.identity_company_number.blank?

		uri = URI.escape("http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_bas.cgi?ico=#{self.identity_company_number}")
		uri = URI.parse(uri)
		res = Net::HTTP.get_response(uri)
		body = Hash.from_xml(res.body)

		help = body['Ares_odpovedi']['Odpoved']['VBAS']

		return remove_from_ares if help.blank?

		trades_help = help['Obory_cinnosti']

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
end