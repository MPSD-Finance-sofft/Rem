class Accord < ApplicationRecord
	has_paper_trail ignore: [:updated_at, :id]
	include AccordsEnum
	include RemoveWhiteSpiceFromNumberInput::Accord
	include Versions::Base
	validates_with AccordValidator
	attr_accessor :current_user

	has_many :accords_realty, :dependent => :destroy
	has_many :accords_clients, :dependent => :destroy

	has_many :realty, through: :accords_realty
  has_many :address, foreign_key: 'address_id', class_name: 'Address', through: :realty
	has_many :clients, through: :accords_clients
	has_many :commitments, :dependent => :destroy
	has_many :expenses, :dependent => :destroy
	has_many :notes, :dependent => :destroy
	has_many :expert_evidences, :dependent => :destroy
	has_many :energies, :dependent => :destroy
	has_many :eletricities, :dependent => :destroy
	has_many :gas_energies, :dependent => :destroy
	has_many :water_energies, :dependent => :destroy
	has_many :leasing_contracts, :dependent => :destroy
	has_many :tax_returns, :dependent => :destroy
	has_many :insurances, :dependent => :destroy
	has_many :penbs, :dependent => :destroy
	has_many :flat_admistrations, :dependent => :destroy
	has_many :month_advences, :dependent => :destroy
	has_many :terrains, :dependent => :destroy
	has_many :planned_prices, :dependent => :destroy
  has_many :sales_contracts, :dependent => :destroy
	has_one :reward, :dependent => :destroy
	has_many :accord_reason_refusals, :dependent => :destroy
  has_many :registers, :dependent => :destroy
	belongs_to :creator, foreign_key: 'creator_id', class_name: 'User',  required: true
	belongs_to :owner, foreign_key: 'user_id', class_name: 'User' ,  required: false
	belongs_to :agent, foreign_key: 'agent_id', class_name: 'User' ,  required: false
	belongs_to :agent_in_signature, foreign_key: 'agent_in_signature_id', class_name: 'User' ,  required: false

	has_many_attached :uploads_agent
	has_many_attached :uploads_manager
	has_many_attached :land_registry
	has_many_attached :constract_files
	has_many_attached :constract_file
	has_many_attached :documents
	has_many_attached :reminders

	accepts_nested_attributes_for :accords_realty,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :accords_clients,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :commitments,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :expenses,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :expert_evidences,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :energies,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :eletricities,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :gas_energies,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :water_energies,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :tax_returns,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :insurances,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :penbs,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :flat_admistrations,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :month_advences,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :terrains,  reject_if: :all_blank, allow_destroy: true

	validates :state, :inclusion => {:in => states.keys}

	after_create :add_number
	before_update :add_notification_change_state

	ACTIVE_STATE = ['state_new', 'state_eleboration', 'in_terrain', 'returned', 'to_sign']

	def commission_for_the_contract
		if self.reward
		  self.reward.commission_for_the_contract.to_f
		elsif self.agent.try(:commission).to_f > 0
		  self.purchase_price.to_f * ( self.agent.commission.to_f / 100 ) 
		else
		  self.purchase_price.to_f * self.agent.try(:commission_for_count_accords).to_f
		end
	end

	def agency_commission_price
    self.reward ?  self.reward.agency_commission.to_f : self.purchase_price.to_f * (self.agency_commission.to_f / 100)
  end

  def contract?
  	self.state == "contract"
  end

  def persons
		self.clients.where(type: "Person")
	end

	def companies
		self.clients.where(type: "Company")
	end

	def active_terrain?
		!self.terrains.blank? && self.terrains.last.try(:date_end_terrain).blank?
	end

	def add_number
		if self.number.blank?
			self.number = self.id
			self.save
		end
	end

	def last_active_terrains
		self.terrains.active.last
	end

	def last_terrains
		self.terrains.last
	end

	def add_notification_change_state
		Notification::for_change_state_accord(self) if self.state_changed?
	end

	def alerts
		Alert.where(object_id: self.id).where(object: "Accord")
	end

	def active_state_between_date?(arr)
		!(self.object_attributes_valuee_in_between(arr,'state') & ACTIVE_STATE).blank?
	end

  def self.automatic_add_energy_task
    list = []
    Accord.automatic_add_energy.each do |accord|
      e = accord.eletricities.last
      unless e.nil?
        a = true if e.duplicate
      end

      e = accord.gas_energies.last
      unless e.nil?
        a = true if e.duplicate
      end

      e = accord.water_energies.last
      unless e.nil?
        a = true if e.duplicate
      end

      unless a.nil?
        list << accord.id
      end
    end
    SchedulerLog.create(kind: 'AccordEnergies', list: list) unless list.blank?
  end

  def self.automatic_add_month_advances
    list = []
    Accord.automatic_svj.each do |accord|
      e = accord.month_advences.last
      unless e.nil?
        a = true if e.duplicate
      end

      unless a.nil?
        list << accord.id
      end
    end
    SchedulerLog.create(kind: 'AccordMonthAdvances', list: list) unless list.blank?
  end

	def self.count_account_total_unfinished_state(user)
		Accord.state(Accord::ACTIVE_STATE).user_id_without_blank(user).count
	end

  def self.user_id(user_id)
    where(user_id: user_id.map{|a| a == 'bez pečovatele' ? nil : a})
  end

  def self.agent_id(agent_id)
    where(agent_id: agent_id.map{|a| a == 'bez agenta' ? nil : a}.map{|a| a == 'jen agenti' ? User.all.pluck(:id) : a })
  end

  def self.contract_without_sales_contract(test)
    contract =  Accord.contract.pluck(:id)
    contract_with_sales_contract = Accord.with_sales_contract.pluck(:id)
    Accord.where(id: contract.reject{|x| contract_with_sales_contract.include?(x)})
  end

  scope :automatic_add_energy, -> {where(automatik_add_energy: true)}
  scope :automatic_svj, -> {where(automatic_svj: true)}
	scope :subordinates_accords, -> (user) {where(agent_id: [User.where(superior_id: user.id).pluck(:id)])}
	scope :agents_accords, -> (user) {where(agent_id:  user.id)}
  scope :with_sales_contract, -> {joins(:sales_contracts)}
	scope :agent_terrain, -> (user) {where(agent_terrain_id:  user.id)}
  scope :user_id_without_blank, -> (user) {where(user_id:  user.id)}
	scope :agent_signature, -> (id) {where(agent_in_signature_id:  id)}
	scope :number_accord, -> (number_accord) {where(number:  number_accord)}
  scope :created_by, -> (user_id) {where(creator_id:  user_id)}
	scope :contract_number, -> (contract_number) {where(contract_number:  contract_number)}
	scope :kind, -> (kind) {where(kind:  kind)}
	scope :state, -> (state) {where(state:  state)}
	scope :start_created_at, -> (date) {where("accords.created_at >= ?", date.to_date)}
	scope :end_created_at, -> (date) {where("accords.created_at <= ?", date.to_date + 1.day)}
	scope :date_of_signature_start, -> (date) {where("accords.date_of_signature >= ?", date.to_date)}
	scope :date_of_signature_end, -> (date) {where("accords.date_of_signature <= ?", date.to_date)}
	scope :repurchase_min, -> (number) {where("accords.repurchase > ?", number)}
	scope :repurchase_max, -> (number) {where("accords.repurchase < ?", number)}
	scope :client_personal_identification_number, -> (personal_identification_number) {joins(:clients).where("clients.personal_identification_number LIKE ?", "%#{personal_identification_number}%")}
	scope :client_name, -> (client_name) {joins(:clients).where("clients.name LIKE ?", "%#{client_name}%")}
	scope :client_last_name, -> (client_last_name) {joins(:clients).where("clients.last_name LIKE ?", "%#{client_last_name}%")}
	scope :realty_type, -> (realty_type_id) {joins(:realty).where("realties.realty_type_id": realty_type_id)}
	scope :superior_id, -> (superior_id) {joins(:agent).where("users.superior_id": superior_id)}
	scope :realty_adress_street, -> (street) {joins(realty: :address).where("addresses.street LIKE ?", "%#{street}%")}
	scope :realty_adress_village, -> (village) {joins(realty: :address).where("addresses.village LIKE ?","%#{village}%")}
	scope :date_to_terrain_start, -> (date) {joins(:terrains).distinct.where("terrains.date_to_terrain >= ?", date.to_date)}
	scope :date_to_terrain_end, -> (date) {joins(:terrains).distinct.where("terrains.date_to_terrain <= ?", date.to_date)}
	scope :date_end_terrain_start, -> (date) {joins(:terrains).distinct.where("terrains.date_end_terrain >= ?", date.to_date)}
	scope :date_end_terrain_end, -> (date) {joins(:terrains).distinct.where("terrains.date_end_terrain <= ?", date.to_date)}
	scope :agent_in_terrain, -> (agent) {joins(:terrains).distinct.where("terrains.agent_id": agent)}
	scope :accord_for_manager, -> (manager) {eager_load(:terrains).where("terrains.agent_id = ? OR accords.agent_id = ? OR accords.agent_id IN (?)", manager.id,manager.id,User.subordinates(manager).pluck(:id))}
end
