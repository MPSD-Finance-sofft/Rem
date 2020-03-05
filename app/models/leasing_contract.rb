class LeasingContract < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include LeasingContractsEnum
	include LeasingContract::RepaymentCalendar
	include RemoveWhiteSpiceFromNumberInput::LeasingContract

	has_many :payments, -> {order 'payment_date asc'}, :dependent => :destroy
	has_many :repayments, -> {order 'repayment_date asc'},  :dependent => :destroy
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

	 validates :expected_date_of_signature, presence: true

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
		self.accord.accords_clients.each do |accords_client|
			client = accords_client.client
			LeasingContractClient.create(client_id: client.id, leasing_contract_id: self.id, relationship: accords_client.relationship)
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
		number > 0
	end

	def active?
		return false if self.added?
		return false if self.debt?
		(self.expected_date_of_signature) && (self.expected_date_of_signature <= Date.today)
	end

	def added?
		self.repayments.sum(:amount).to_f <= self.payments.sum(:amount).to_f
	end

	def alerts
		Alert.where(object_id: self.id).where(object: "LeasingContract")
	end

	def debt
		self.repayments.includes(:repayment_payment).repayment_date_today.not_paid.sum{|a| a.missing_to_pay}
	end

	def start_date_debt
		self.repayments.includes(:repayment_payment).repayment_date_today.not_paid.first.try(:repayment_date)
	end

	def recalculation_payments
		new_repayment_payment = false
		i = 0
		while self.repayments.size >= i do
			repayment = self.repayments[i]
			payments = self.payments.not_paid

			return new_repayment_payment if payments.blank?
			next  i = i + 1 if repayment.nil? || repayment.paid?
			payment = payments.first

			result = repayment.missing_to_pay - payment.to_be_paid
			result < 0 ? result = repayment.missing_to_pay : result  = payment.to_be_paid

			RepaymentPayment.create(payment_id: payment.id, repayment_id: repayment.id, amount: result)
			new_repayment_payment = true
		end
		new_repayment_payment
	end

	def reset_rent
		RepaymentPayment.where(id: payments.map{|a| a.repayment_payment.ids}.flatten).delete_all
		recalculation_payments
		change_state
	end

	def change_state
		return false if state == 'ended'

		if debt?
			help_state = 'debt'
		elsif added?
			help_state = 'added'
		elsif active?
			help_state = 'actions'
		end

		if help_state != state
			self.state = help_state
			self.save
			true
		else
			false
		end
	end

	def debt_more_then_ten_day?
		return if start_date_debt.nil?
		Date.today - start_date_debt > 10
	end

	def self.all_debt
		LeasingContract.includes(repayments: :repayment_payment).state('debt').sum(&:debt)
	end

	def self.recalculation_payments
		list = []
		LeasingContract.all.each do |leasing_contract|
			list << leasing_contract.id if leasing_contract.recalculation_payments
		end
		SchedulerLog.create(kind: 'LeasigContractRecalculationPayments', list: list) unless list.blank?
	end

	def self.change_state
		list = []
		 LeasingContract.all.each do |leasing_contract|
			list << leasing_contract.id if leasing_contract.change_state
		end
		SchedulerLog.create(kind: 'LeasigContractChangeState', list: list) unless list.blank?
	end

	def last_recalculation
		SchedulerLog.for_leasig_contract.where("list LIKE ?", "%#{self.id}%").order(created_at: :desc).select{|a| a.list.match(/\D#{self.id}\D/)}.first.try(:created_at)
	end

	def self.payment_calendar_for_year(year=2020)
		Payment::for_year(year)
	end

  def self.payment_calendar_for_year_prepaid(year=2020)
    Payment::for_year(year, Payment::PREPAID)
  end

	def self.repayment_calendar_for_year(year=2020)
		Repayment::for_year(year)
	end

	def self.difference_payment_repayment_calendar(year=2020)
		result = {}
    prepaid = Repayment::for_year_prepaid(year)
		Repayment::for_year(year).each do |k,v|
			result.merge!("#{k}": v - prepaid[k].to_f)
		end
		result
	end

  def self.year_prepaid_month(year=2020)
    Repayment::for_year_prepaid(year)
  end

	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
	scope :contract_number, -> (contract_number) {where(id:  contract_number)}
	scope :state, -> (state) {where(state:  state)}
  scope :kind, -> (kind) {where(kind:  kind)}
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
