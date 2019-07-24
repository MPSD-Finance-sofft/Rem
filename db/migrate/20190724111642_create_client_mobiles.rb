class CreateClientMobiles < ActiveRecord::Migration[5.2]
  def change
    create_table :client_mobiles do |t|
      t.integer :client_id
      t.integer :mobile_id

      t.timestamps
    end
  end
end
