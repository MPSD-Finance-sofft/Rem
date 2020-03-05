class RepaymentPayment < ApplicationRecord
	belongs_to :repayment
	belongs_to :payment

	def ussles?
		repayment.blank? || payment.blank?
	end

  def prepaid_payment?
    payment.prepaid?
  end

	def self.remove_ussles
		RepaymentPayment.where(id: RepaymentPayment.includes(:repayment,:payment).select(&:ussles?).map(&:id)).delete_all
	end
end
