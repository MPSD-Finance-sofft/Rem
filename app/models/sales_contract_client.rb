class SalesContractClient < ApplicationRecord
  has_paper_trail

  include AccordsClientEnum

  belongs_to :sales_contract
  belongs_to :client
  accepts_nested_attributes_for :client,  reject_if: :all_blank, allow_destroy: true

  validates :relationship, :inclusion => {:in => relationships.keys}

  def self.remove_usseles_record
    select{|a| a.client.nil? || a.sales_contract.nil?}.map(&:delete)
  end
end
