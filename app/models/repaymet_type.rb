class RepaymetType < ApplicationRecord
	scope :repayment_for_date , -> (date) {where("start_date <= ? ",date.to_date)}
	scope :not_for_cron, -> {where( cron: false)}
	scope :for_cron, -> {where( cron: true)}
end
