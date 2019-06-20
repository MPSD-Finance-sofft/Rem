class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.integer :accord_id
      t.integer :user_id
      t.decimal :agency_commission
      t.decimal :commission_for_the_contract
      t.date :invoice_date
      t.date :payout_date

      t.timestamps
    end
  end
end
