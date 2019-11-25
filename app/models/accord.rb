class Accord < ApplicationRecord
	has_paper_trail ignore: [:updated_at, :id]
	include AccordsEnum
	include RemoveWhiteSpiceFromNumberInput::Accord
	validates_with AccordValidator
	attr_accessor :current_user
	
	has_many :accords_realty, :dependent => :destroy
	has_many :accords_clients, :dependent => :destroy

	has_many :realty, through: :accords_realty
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
	has_one :reward, :dependent => :destroy
	belongs_to :creator, foreign_key: 'creator_id', class_name: 'User',  required: true
	belongs_to :owner, foreign_key: 'user_id', class_name: 'User' ,  required: false
	belongs_to :agent, foreign_key: 'agent_id', class_name: 'User' ,  required: false

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

	def commission_for_the_contract
		self.purchase_price.to_f * 0.03
	end

	def agency_commission_price
    	self.purchase_price.to_f * (self.agency_commission.to_f / 100)
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

	def add_notification_change_state
		Notification::for_change_state_accord(self) if self.state_changed?
	end

	scope :subordinates_accords, -> (user) {where(agent_id: [User.where(superior_id: user.id).pluck(:id)])}
	scope :agents_accords, -> (user) {where(agent_id:  user.id)}
	scope :agent_terrain, -> (user) {where(agent_terrain_id:  user.id)}
	scope :number_accord, -> (number_accord) {where(number:  number_accord)}
	scope :user_id, -> (user_id) {where(user_id:  user_id)}
	scope :agent_id, -> (agent_id) {where(agent_id:  agent_id)}
	scope :contract_number, -> (contract_number) {where(contract_number:  contract_number)}
	scope :kind, -> (kind) {where(kind:  kind)}
	scope :state, -> (state) {where(state:  state)}
	scope :start_created_at, -> (date) {where("accords.created_at > ?", date.to_date)}
	scope :end_created_at, -> (date) {where("accords.created_at < ?", date.to_date)}
	scope :date_of_signature_start, -> (date) {where("accords.date_of_signature > ?", date.to_date)}
	scope :date_of_signature_end, -> (date) {where("accords.date_of_signature < ?", date.to_date)}
	scope :repurchase_min, -> (number) {where("accords.repurchase > ?", number)}
	scope :repurchase_max, -> (number) {where("accords.repurchase < ?", number)}
	scope :client_personal_identification_number, -> (personal_identification_number) {joins(:clients).where("clients.personal_identification_number LIKE ?", "%#{personal_identification_number}%")}
	scope :client_name, -> (client_name) {joins(:clients).where("clients.name LIKE ?", "%#{client_name}%")}
	scope :client_last_name, -> (client_last_name) {joins(:clients).where("clients.last_name LIKE ?", "%#{client_last_name}%")}
	scope :realty_type, -> (realty_type_id) {joins(:realty).where("realties.realty_type_id": realty_type_id)}
	scope :superior_id, -> (superior_id) {joins(:agent).where("users.superior_id": superior_id)}
	scope :realty_adress_street, -> (street) {joins(realty: :address).where("addresses.street LIKE ?", "%#{street}%")}
	scope :realty_adress_village, -> (village) {joins(realty: :address).where("addresses.village LIKE ?","%#{village}%")}
	scope :date_to_terrain_start, -> (date) {joins(:terrains).distinct.where("terrains.date_to_terrain > ?", date.to_date)}
	scope :date_to_terrain_end, -> (date) {joins(:terrains).distinct.where("terrains.date_to_terrain < ?", date.to_date)}
	scope :date_end_terrain_start, -> (date) {joins(:terrains).distinct.where("terrains.date_end_terrain > ?", date.to_date)}
	scope :date_end_terrain_end, -> (date) {joins(:terrains).distinct.where("terrains.date_end_terrain < ?", date.to_date)}
	scope :agent_in_terrain, -> (agent) {joins(:terrains).distinct.where("terrains.agent_id": agent)}
end
