module RemoveWhiteSpiceFromNumberInput::MarketPlace

	def market_place=(value)
		self[:market_place] = value.to_s.delete(" ")
	end

end