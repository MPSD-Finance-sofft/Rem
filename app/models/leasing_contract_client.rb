class LeasingContractClient < ApplicationRecord
	has_paper_trail
	
	include AccordsClientEnum
	
	belongs_to :leasing_contract
  	belongs_to :client
	accepts_nested_attributes_for :client,  reject_if: :all_blank, allow_destroy: true
	
	validates :relationship, :inclusion => {:in => relationships.keys}
end
