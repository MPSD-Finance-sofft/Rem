module LeasingContract::RepaymentCalendar
	
	def calendar
		sum_payment = self.payments.sum(:amount)
		repayments = self.repayments
		repayments.each do |repayment|
			repayment.paid = :not_paid
			repayment.paid = :debt if repayment.repayment_date < Date.today
			repayment.paid = :paid if (sum_payment.to_f - repayment.amount.to_f) >= 0
			sum_payment = sum_payment.to_f - repayment.amount.to_f
		end
		repayments.map{|a| a.decorate}
	end

	def calendar_for_year(year)
		repayments.select{|a| a.for_year?(year)}
	end
end