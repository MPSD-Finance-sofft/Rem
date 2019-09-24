class Reward < ApplicationRecord
	
	belongs_to :accord
	belongs_to :invoice, required: false
	belongs_to :agent, foreign_key: 'user_id', class_name: 'User' ,  required: false

	def create_reward(accord)
		self.accord_id= accord.id
		self.user_id = accord.agent_id
		self.agency_commission = accord.agency_commission_price
		self.commission_for_the_contract = accord.commission_for_the_contract
	end

	
	def invoice_date
		self.invoice.try(:created_at) 
	end

	def purchase_price
		accord.purchase_price
	end

	scope :invoice, -> (invoice_id) {where(invoice_id: invoice_id)}
	scope :for_user, -> (user_id) {where(user_id: user_id)}
	scope :without_invoice, ->  {where("invoice_id is NULL")}

end
