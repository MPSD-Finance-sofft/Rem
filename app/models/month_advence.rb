class MonthAdvence < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Price
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
  belongs_to :accord

  def duplicate
    return false if self.date_due.nil? || self.date_due.month == Date.today.month
    e = self.dup
    e.date_due = self.date_due + 1.month
    e.date_of_payment = self.date_of_payment + 1.month
    e.save
  end

  def self.chart_for_year(year= 2021)
    month_advence = {}
    MonthAdvence.where("date_of_payment <= ? AND date_of_payment > ?", Date.new(year,12,31), Date.new(year,1,1)).select("created_at, month(date_of_payment) as month, year(date_of_payment) as year, sum(price) as amount").group(:month,:year).each do |a|
      month_advence.merge!("#{Date.new(a.year, a.month,1)}": a.amount)
    end
    month_advence
  end
end
