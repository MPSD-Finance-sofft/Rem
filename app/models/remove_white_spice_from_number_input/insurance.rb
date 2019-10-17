module RemoveWhiteSpiceFromNumberInput::Insurance

	def price=(value)
		self[:price] = value.delete(" ")
	end

end