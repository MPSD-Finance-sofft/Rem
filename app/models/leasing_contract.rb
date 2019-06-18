class LeasingContract < ApplicationRecord
	include LeasingContractsEnum

	has_many :payments, :dependent => :destroy
	has_many :repayments, :dependent => :destroy
end
