class Invoice < ApplicationRecord
	has_many :rewards

	def self.create_invoice(agent_id)
		rewards_arr = Reward.for_user(agent_id).without_invoice.group_by { |t| t.created_at.beginning_of_month }
		rewards_arr.each do |date, rewards|
			Invoice.transaction  do
				i = Invoice.create(period_year: date.year, period_month: date.month)
				rewards.each do |reward|
					reward.invoice_id = i.id
					reward.save!
				end
			end
		end
	end

	def agent
		self.rewards.first.try(:agent)
	end
end
