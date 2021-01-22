module Reports::LeasingContracts
  def accords_by_month
    Accord.where(state: 'contract').select("accords.created_at, month(date_of_signature) as month, year(date_of_signature) as year").group(:month,:year).map{|a| [Date.new(a.year, a.month,1)]}.sort_by(&:first)
  end

  def sum_purchace_price_for_period(from, to)
    Accord.where(state: 'contract').where.not(id: sales_contract_from_period(from, to)).where("date_of_signature <= ? AND date_of_signature >= ?", to,from).sum(:purchase_price)
  end

  def count_purchace_price_for_period(from, to)
    Accord.where(state: 'contract').where.not(id: sales_contract_from_period(from, to)).where("date_of_signature <= ? AND date_of_signature >= ?", to,from).count
  end

  def count_leasing_contract_from_period(from, to )
    LeasingContract.where.not(accord_id: sales_contract_from_period(from, to)).where("rent_from <= ? AND rent_from >= ?",to, from).count
  end

  def sum_purchace_price_leasing_contract_from_period(from, to)
    LeasingContract.where.not(accord_id: sales_contract_from_period(from, to)).where("rent_from <= ? AND rent_from >= ?",to, from).joins(:accord).sum(:purchase_price)
  end

  def sum_monthly_rent_leasing_contract_from_period(from, to)
    LeasingContract.where.not(accord_id: sales_contract_from_period(from, to)).where("rent_from <= ? AND rent_from >= ?",to, from).sum(:monthly_rent)
  end 

  def sum_payments_rent_leasing_contract_from_period(from, to)
    Payment.where("payment_date <= ? AND payment_date >= ?", to, from).sum(:amount)
  end

  def sales_contract_from_period(from, to)
    SalesContract.where("date_of_sale_realty <= ? AND date_of_sale_realty >= ?", to, from).pluck(:accord_id)
  end

end
