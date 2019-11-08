module RemoveWhiteSpiceFromNumberInput::Realty

	def purchase_price=(value)
		self[:purchase_price] = value.delete(" ")
	end
	
	def price_estimation=(value)
		self[:price_estimation] = value.delete(" ")
	end

end