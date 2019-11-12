module RemoveWhiteSpiceFromNumberInput::Price

	def price=(value)
		self[:price] = value.to_s.delete(" ")
	end

end