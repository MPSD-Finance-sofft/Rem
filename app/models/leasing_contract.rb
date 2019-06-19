class LeasingContract < ApplicationRecord
	include LeasingContractsEnum

	has_many :payments, :dependent => :destroy
	has_many :repayments, :dependent => :destroy
	
	accepts_nested_attributes_for :repayments,  reject_if: :all_blank, allow_destroy: true

	MAX_GENERATE_REPAYMENTS = 100

	def generate_repayments
		i =0 
		range  = (self.rent_to.year * 12 + self.rent_to.month) - (self.rent_from.year * 12 + self.rent_from.month)
		range.times do
			date = Date.new(self.rent_to.year, self.rent_to.month,payment_day) + i.month
			self.repayments.build(leasing_contract_id: self.id, amount: self.monthly_rent, repayment_date: date)
			i = i + 1
		end if range < MAX_GENERATE_REPAYMENTS
	end

end
