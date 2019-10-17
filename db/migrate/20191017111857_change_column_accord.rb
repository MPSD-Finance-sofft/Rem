class ChangeColumnAccord < ActiveRecord::Migration[5.2]
  def change
	change_column :insurances, :date_of_payment, :date
  end
end
