class Ares < ApplicationRecord
	belongs_to :user

  validates :nace, presence: true
  validates :nace_name, presence: true

  def full_name
    nace + " " + nace_name
  end
end
