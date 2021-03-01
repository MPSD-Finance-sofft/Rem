class Energy < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Price
	include EnergiesEnum
	belongs_to :distributor
  belongs_to :accord

  def duplicate
    return false if self.payment_day.nil? || self.payment_day.month == Date.today.month
    e = self.dup
    e.date_of = self.date_of + 1.month unless self.date_of.nil?
    e.payment_day = self.payment_day + 1.month
    e.save
  end

  def self.chart_for_year(year= 2021)
    electricity = {}
    Eletricity.where("payment_day <= ? AND payment_day > ?", Date.new(year,12,31), Date.new(year,1,1)).select("created_at, month(payment_day) as month, year(payment_day) as year, sum(price) as amount").group(:month,:year).each do |a|
      electricity.merge!("#{Date.new(a.year, a.month,1)}": a.amount)
    end
    water_energy = {}
    WaterEnergy.where("payment_day <= ? AND payment_day > ?", Date.new(year,12,31), Date.new(year,1,1)).select("created_at, month(payment_day) as month, year(payment_day) as year, sum(price) as amount").group(:month,:year).each do |a|
      water_energy.merge!("#{Date.new(a.year, a.month,1)}": a.amount)
    end
    gas_energy = {}
    GasEnergy.where("payment_day <= ? AND payment_day > ?", Date.new(year,12,31), Date.new(year,1,1)).select("created_at, month(payment_day) as month, year(payment_day) as year, sum(price) as amount").group(:month,:year).each do |a|
      gas_energy.merge!("#{Date.new(a.year, a.month,1)}": a.amount)
    end
    result=[{name: 'Elektřina', data: electricity}, {name: 'Plyn', data: gas_energy}, {name: 'Voda', data: water_energy}]
  end
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
