class AddExpertEvidenceDeliveryDate < ActiveRecord::Migration[5.2]
  def change
  	add_column :expert_evidences, :delivery_date, :date
  end
end
