module RemoveWhiteSpiceFromNumberInput::Accord

	def purchase_price=(value)
		self[:purchase_price] = value.delete(" ")
	end
	
	def repurchase=(value)
		self[:repurchase] = value.delete(" ")
	end

end