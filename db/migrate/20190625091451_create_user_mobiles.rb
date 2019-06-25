class CreateUserMobiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_mobiles do |t|
      t.integer :user_id
      t.integer :mobile_id

      t.timestamps
    end
  end
end
