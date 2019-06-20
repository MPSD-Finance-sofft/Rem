class Reward < ApplicationRecord
	
	belongs_to :accord
	belongs_to :agent, foreign_key: 'user_id', class_name: 'User' ,  required: false

	def create_reward(accord)
		self.accord_id= accord.id
		self.user_id = accord.agent_id
		self.agency_commission = accord.agency_commission_price
		self.commission_for_the_contract = accord.commission_for_the_contract
	end

end
