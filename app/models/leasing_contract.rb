class LeasingContract < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include LeasingContractsEnum
	include LeasingContract::RepaymentCalendar
	include RemoveWhiteSpiceFromNumberInput::LeasingContract

	has_many :payments, :dependent => :destroy
	has_many :repayments, :dependent => :destroy
	has_many :leasing_contract_clients, :dependent => :destroy
	has_many :leasing_contract_realty, :dependent => :destroy

	has_many :realty, through: :leasing_contract_realty
	has_many :clients, through: :leasing_contract_clients
	
	belongs_to :accord
	belongs_to :user,  required: false
	has_many_attached :uploads

	accepts_nested_attributes_for :repayments,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :payments,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :leasing_contract_clients,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :leasing_contract_realty,  reject_if: :all_blank, allow_destroy: true
	
	after_create :add_realty
	after_create :add_client

	MAX_GENERATE_REPAYMENTS = 100

	def generate_repayments
		i = 0
		exist_repayment_date = Repayment.for_leasing_contract(self.id).pluck(:repayment_date)
		range  = (self.rent_to.year * 12 + self.rent_to.month) - (self.rent_from.year * 12 + self.rent_from.month)
		range.times do
			date = Date.new(self.rent_from.year, self.rent_from.month, payment_day) + i.month
			self.repayments.build(leasing_contract_id: self.id, amount: self.monthly_rent, repayment_date: date) unless exist_repayment_date.include?(date)
			i = i + 1
		end if range < MAX_GENERATE_REPAYMENTS
	end

	def add_realty
		id =  self.accord.realty.first.try(:id)
    	self.leasing_contract_realty.build(realty_id: id) unless id.blank?
    	self.save
	end

	def add_client
		self.accord.clients.each do |client|
			id =  client.id
			LeasingContractClient.create(client_id: client.id, leasing_contract_id: self.id, relationship: client.accords_client.relationship)
    		self.save
    	end
	end

	def persons
		self.clients.where(type: "Person")
	end

	def companies
		self.clients.where(type: "Company")
	end

	def debt?
		number = self.debt
		number > 0 && self.state != 'ended'
	end

	def active?
		!debt? && self.state != 'ended'
	end

	def added?
		self.state != 'ended' && self.repayments.sum(:amount).to_f == self.payments.sum(:amount).to_f 
	end

	def alerts
		Alert.where(object_id: self.id).where(object: "LeasingContract")
	end

	def debt
		self.repayments.repayment_date_today.sum(:amount).to_f - self.payments.sum(:amount).to_f 
	end
	
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
	scope :contract_number, -> (contract_number) {where(id:  contract_number)}
	scope :state, -> (state) {where(state:  state)}
	scope :user_id, -> (user_id) {where(user_id:  user_id)}
	scope :client_name, -> (client_name) {joins(:clients).where("clients.name": client_name)}
	scope :client_last_name, -> (client_last_name) {joins(:clients).where("clients.last_name": client_last_name)}
	scope :realty_type, -> (realty_type_id) {joins(:realty).where("realties.realty_type_id": realty_type_id)}
	scope :realty_adress_street, -> (street) {joins(realty: :address).where("addresses.street LIKE ?", "%#{street}%")}
	scope :realty_adress_village, -> (village) {joins(realty: :address).where("addresses.village LIKE ?","%#{village}%")}
	scope :monthly_rent_min, -> (number) {where("leasing_contracts.monthly_rent > ?", number)}
	scope :monthly_rent_max, -> (number) {where("leasing_contracts.monthly_rent < ?", number)}
	scope :rent_to_start, -> (date) {where("leasing_contracts.rent_to > ?", date.to_date)}
	scope :rent_to_end, -> (date) {where("leasing_contracts.rent_to < ?", date.to_date)}
	scope :subordinates_accords, -> (user) {joins(:accord).where('accords.agent_id': [User.where(superior_id: user.id).pluck(:id)])}
	scope :agents_accords, -> (user) {joins(:accord).where('accords.agent_id':  user.id)}
end
