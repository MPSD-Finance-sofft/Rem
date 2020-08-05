class Register < ApplicationRecord

  has_paper_trail ignore: [:updated_at, :id]

  belongs_to :accord
  belongs_to :client
  belongs_to :user
end
