module RemoveWhiteSpiceFromNumberInput::TaxReturn

	def price=(value)
		self[:price] = value.delete(" ")
	end

end