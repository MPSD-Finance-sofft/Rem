class SchedulerLog < ApplicationRecord


	def list_arr
		self.list.scan(/\d+/).map(&:to_i)
	end

	scope :for_client, -> {where(kind:  'Client')}
	scope :for_leasig_contract, -> {where(kind:  ['LeasigContractRecalculationPayments', 'LeasigContractChangeState'])}
end
