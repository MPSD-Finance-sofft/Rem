class SalesContract < ApplicationRecord
  has_paper_trail ignore: [:updated_at]
  include RemoveWhiteSpiceFromNumberInput::SalesContract

  belongs_to :accord
  belongs_to :user
  has_many :sales_contract_clients, :dependent => :destroy
  has_many :sales_contract_realty, :dependent => :destroy

  has_many :realty, through: :sales_contract_realty
  has_many :clients, through: :sales_contract_clients

  accepts_nested_attributes_for :sales_contract_clients,  reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :sales_contract_realty,  reject_if: :all_blank, allow_destroy: true

  after_create :add_realty
  after_create :add_client


  def add_client
    self.accord.accords_clients.each do |accords_client|
      client = accords_client.client
      SalesContractClient.create(client_id: client.id, sales_contract_id: self.id, relationship: accords_client.relationship)
    end
  end

  def add_realty
    self.accord.accords_realty.each do |accords_realty|
      realty = accords_realty.realty
      SalesContractRealty.create(realty_id: realty.id, sales_contract_id: self.id)
    end
  end

  def persons
    self.clients.where(type: "Person")
  end

  def companies
    self.clients.where(type: "Company")
  end

  def purchase_price
    if accord.realty.count > 1
      purchase_price_by_realty
    else
      accord.purchase_price
    end
  end

  def purchase_price_by_realty
    self.sales_contract_realty.map{|scr| scr.realty.purchase_price}.sum
  end

  def all_sales_prices_filled_in?
    self.sales_contract_realty.select{|a| a.realty.purchase_price.blank? || a.realty.purchase_price == 0 }.blank?
  end

  scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
