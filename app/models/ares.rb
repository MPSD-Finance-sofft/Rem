class Ares < ApplicationRecord
	belongs_to :user

  def full_name
    nace + " " + nace_name
  end
end
