class Realty < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RealtieEnum
	include RemoveWhiteSpiceFromNumberInput::Realty
	validates_with RealtyValidator

  	has_many :realty_record_on_lvs
    has_many :revisions
  	has_many :record_on_lvs, through: :realty_record_on_lvs
    belongs_to :disposition, required: false
  	belongs_to :realty_type, required: false
  	belongs_to :address, required: false
  	accepts_nested_attributes_for :address,  reject_if: :all_blank, allow_destroy: true
  	accepts_nested_attributes_for :record_on_lvs,  reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :revisions,  reject_if: :all_blank, allow_destroy: true
end
