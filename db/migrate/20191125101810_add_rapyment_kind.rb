class AddRapymentKind < ActiveRecord::Migration[5.2]
  def change
  	add_column :repayments, :repayment_type_id, :integer
  end
end
