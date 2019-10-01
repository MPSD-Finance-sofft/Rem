module RemoveWhiteSpiceFromNumberInput::Accord

	def purchase_price=(value)
		self[:purchase_price] = value.delete(" ")
	end

end