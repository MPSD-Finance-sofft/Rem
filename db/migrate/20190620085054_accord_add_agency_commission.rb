class AccordAddAgencyCommission < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :agency_commission, :decimal
  end
end
