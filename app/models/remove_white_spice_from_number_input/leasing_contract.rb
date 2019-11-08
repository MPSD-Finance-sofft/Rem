module RemoveWhiteSpiceFromNumberInput::LeasingContract

	def monthly_rent=(value)
		self[:monthly_rent] = value.to_s.delete(" ")
	end

end