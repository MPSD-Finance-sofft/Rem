class Reward < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::Reward
	has_paper_trail ignore: [:updated_at]
	belongs_to :accord
	belongs_to :invoice, required: false
	belongs_to :agent, foreign_key: 'user_id', class_name: 'User'

  validate :check_agency_commission

	def create_reward(accord)
		self.accord_id= accord.id
		self.user_id = accord.agent_id
		self.agency_commission = accord.agency_commission_price
		self.commission_for_the_contract = accord.commission_for_the_contract
		self.claim_date = accord.date_of_ownership
	end

	
	def invoice_date
		self.invoice.try(:created_at) 
	end

	def purchase_price
		accord.purchase_price
	end

  def check_agency_commission
    errors.add(:agency_commission, "Tipař nemuže mít zprostředkovatelkou provizi")  if agent.tipster? && agency_commission.to_f != 0
  end

	scope :invoice, -> (invoice_id) {where(invoice_id: invoice_id)}
	scope :for_user, -> (user_id) {where(user_id: user_id)}
	scope :without_invoice, ->  {where("invoice_id is NULL")}
	scope :subordinates_rewards, -> (user) {where(user_id: [User.where(superior_id: user.id).pluck(:id)])}

end
