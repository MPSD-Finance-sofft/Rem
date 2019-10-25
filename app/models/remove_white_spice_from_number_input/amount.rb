module RemoveWhiteSpiceFromNumberInput::Amount

	def amount=(value)
		self[:amount] = value.delete(" ")
	end

end