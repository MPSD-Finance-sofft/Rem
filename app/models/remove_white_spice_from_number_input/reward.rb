module RemoveWhiteSpiceFromNumberInput::Reward

	def agency_commission=(value)
		self[:agency_commission] = value.delete(" ")
	end
	
	def commission_for_the_contract=(value)
		self[:commission_for_the_contract] = value.delete(" ")
	end

end