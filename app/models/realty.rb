class Realty < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RealtieEnum
  	
  	belongs_to :realty_type
  	belongs_to :address, required: false
  	validates :type_ownership, :inclusion => {:in => type_ownerships.keys}
  	accepts_nested_attributes_for :address,  reject_if: :all_blank, allow_destroy: true
end
