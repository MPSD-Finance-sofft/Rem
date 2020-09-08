class MonthAdvence < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Price
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}

  def duplicate
    return false if self.date_due.nil? || self.date_due.month == Date.today.month
    e = self.dup
    e.date_due = self.date_due + 1.month
    e.date_of_payment = self.date_of_payment + 1.month
    e.save
  end

end
