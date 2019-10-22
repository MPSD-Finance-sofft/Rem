class Realty < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RealtieEnum
	validates_with RealtyValidator
  	
  	belongs_to :realty_type, required: false
  	belongs_to :address, required: false
  	accepts_nested_attributes_for :address,  reject_if: :all_blank, allow_destroy: true
end
