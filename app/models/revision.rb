class Revision < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Amount

	belongs_to :user,required: false
	belongs_to :revision_type, required: false

	def done
		(self.datecontrol <= self.delivery_report) if self.datecontrol && self.delivery_report
	end

	scope :for_realty, -> (realty_id) {where(realty_id: realty_id)}
end
