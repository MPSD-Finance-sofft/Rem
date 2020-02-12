class RepaymentPayment < ApplicationRecord
	belongs_to :repayment
	belongs_to :payment

	def ussles?
		repayment.blank? || payment.blank?
	end

	def self.remove_ussles
		RepaymentPayment.where(id: RepaymentPayment.includes(:repayment,:payment).select(&:ussles?).map(&:id)).delete_all
	end
end
