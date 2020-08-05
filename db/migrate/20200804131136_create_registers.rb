class CreateRegisters < ActiveRecord::Migration[5.2]
  def change
    create_table :registers do |t|
      t.integer :accord_id
      t.integer :client_id
      t.string :register_type
      t.boolean :electronic_request
      t.boolean :paper_request
      t.boolean :electronic_extract
      t.boolean :paper_extract
      t.date :payout_date
      t.date :delivery_date

      t.timestamps
    end
  end
end
