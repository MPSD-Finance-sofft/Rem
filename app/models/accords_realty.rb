class AccordsRealty < ApplicationRecord
	has_paper_trail
	
  	belongs_to :accord
  	belongs_to :realty
	accepts_nested_attributes_for :realty,  reject_if: :all_blank, allow_destroy: true
end
