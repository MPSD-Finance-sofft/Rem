class AddRepaymentData < ActiveRecord::Migration[5.2]
  def change
  	add_column :repaymet_types, :text, :string
  	add_column :repaymet_types, :number, :decimal
  	add_column :repaymet_types, :procent,  :decimal
  end
end
