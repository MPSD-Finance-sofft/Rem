class AddExpertevidenceValuationOffice < ActiveRecord::Migration[5.2]
  def change
  	add_column :expert_evidences, :valuation_office, :string
  end
end
