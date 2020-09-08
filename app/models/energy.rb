class Energy < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Price
	include EnergiesEnum
	belongs_to :distributor
  belongs_to :accord

  def duplicate
    return false if self.date_of.month == Date.today.month
    e = self.dup
    e.date_of = self.date_of + 1.month unless self.date_od.nil?
    e.payment_day = self.payment_day + 1.month
    e.save
  end

	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
