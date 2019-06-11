class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :kind

      t.timestamps
    end
  end
end
