class AgentNote < ApplicationRecord

  belongs_to :creator, foreign_key: 'creator_id', class_name: 'User',  required: true
  belongs_to :agent, foreign_key: 'user_id', class_name: 'User' ,  required: false
end
