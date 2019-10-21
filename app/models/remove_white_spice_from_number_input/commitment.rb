module RemoveWhiteSpiceFromNumberInput::Commitment

	def date_of_excepted_payment=(value)
		self[:date_of_excepted_payment] = value.delete(" ")
	end
	
	def payout_day=(value)
		self[:payout_day] = value.delete(" ")
	end

end