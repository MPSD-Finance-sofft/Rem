module RemoveWhiteSpiceFromNumberInput::MarketPlace

	def market_price=(value)
		self[:market_price] = value.to_s.delete(" ")
	end

end