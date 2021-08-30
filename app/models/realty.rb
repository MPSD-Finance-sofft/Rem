class Realty < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RealtieEnum
	include RemoveWhiteSpiceFromNumberInput::Realty
	validates_with RealtyValidator

    has_many :accords_realty, :dependent => :destroy
    has_many :leasing_contract_realty
    has_many :sales_contract_realty

  	has_many :realty_record_on_lvs
    has_many :revisions
  	has_many :record_on_lvs, through: :realty_record_on_lvs
    has_many :accords, through: :accords_realty
    has_many :leasing_contracts, through: :leasing_contract_realty
    has_many :sales_contracts, through: :sales_contract_realty
    belongs_to :disposition, required: false
  	belongs_to :realty_type, required: false
  	belongs_to :address, required: false
  	accepts_nested_attributes_for :address,  reject_if: :all_blank, allow_destroy: true
  	accepts_nested_attributes_for :record_on_lvs,  reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :revisions,  reject_if: :all_blank, allow_destroy: true

    def self.duplications
      Realty.all.group_by{|a| a.address_id}.select{|k,v| v.size > 1}
    end

    def usseles?
      accords_realty.blank? && leasing_contract_realty.blank? && sales_contract_realty.blank?
    end

end
