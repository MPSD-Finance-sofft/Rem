class Accord < ApplicationRecord
	has_paper_trail ignore: [:updated_at, :id]
	include AccordsEnum
	validates_with AccordValidator
	
	has_many :accords_realty, :dependent => :destroy
	has_many :accords_clients, :dependent => :destroy

	has_many :realty, through: :accords_realty
	has_many :clients, through: :accords_clients
	has_many :commitments, :dependent => :destroy
	has_many :expenses, :dependent => :destroy
	has_many :notes, :dependent => :destroy
	has_many :expert_evidences, :dependent => :destroy
	has_many :energies, :dependent => :destroy
	has_many :uploads, :dependent => :destroy
	belongs_to :creator, foreign_key: 'creator_id', class_name: 'User',  required: true
	belongs_to :owner, foreign_key: 'user_id', class_name: 'User' ,  required: false
	belongs_to :agent, foreign_key: 'agent_id', class_name: 'User' ,  required: false
	accepts_nested_attributes_for :accords_realty,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :accords_clients,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :commitments,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :expenses,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :expert_evidences,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :energies,  reject_if: :all_blank, allow_destroy: true

	validates :state, :inclusion => {:in => states.keys}

	def initialize(attributes = {})
		super
		self.state = Accord.states[:state_new]
	end


	def commission_for_the_contract
		self.purchase_price.to_f * 0.03
	end

	def agency_commission_price
    	self.purchase_price.to_f * (self.agency_commission.to_f / 100)
  	end
end
