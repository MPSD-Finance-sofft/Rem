module RemoveWhiteSpiceFromNumberInput::Price

	def price=(value)
		self[:price] = value.delete(" ")
	end

end