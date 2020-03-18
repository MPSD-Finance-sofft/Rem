class SalesContractRealty < ApplicationRecord
  has_paper_trail

  belongs_to :sales_contract
  belongs_to :realty
  accepts_nested_attributes_for :realty,  reject_if: :all_blank, allow_destroy: true

  def self.ussles_record
    all.select{|a| a.realty.nil? || a.sales_contract.nil?}
  end
end
