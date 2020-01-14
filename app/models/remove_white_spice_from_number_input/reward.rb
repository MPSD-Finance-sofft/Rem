module RemoveWhiteSpiceFromNumberInput::Reward

	def agency_commission=(value)
		self[:agency_commission] = value.to_s.delete(" ")
	end

	def commission_for_the_contract=(value)
		self[:commission_for_the_contract] = value.to_s.delete(" ")
	end

end