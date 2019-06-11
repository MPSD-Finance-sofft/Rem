class CreateExpertEvidences < ActiveRecord::Migration[5.2]
  def change
    create_table :expert_evidences do |t|
      t.date :of_date
      t.integer :number
      t.integer :user_id
      t.decimal :price
      t.decimal :market_price
      t.integer :accord_id

      t.timestamps
    end
  end
end
