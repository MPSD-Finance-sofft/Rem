class AddDateOfClaimDateToReward < ActiveRecord::Migration[5.2]
  def change
  	add_column :rewards, :claim_date, :date
  end
end
