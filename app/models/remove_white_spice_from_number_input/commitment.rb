module RemoveWhiteSpiceFromNumberInput::Commitment

	def real_amount=(value)
		self[:real_amount] = value.to_s.delete(" ")
	end
	
	def amount=(value)
		self[:amount] = value.to_s.delete(" ")
	end

end