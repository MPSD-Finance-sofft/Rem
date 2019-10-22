class CreateUserEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_emails do |t|
      t.integer :user_id
      t.integer :email_id

      t.timestamps
    end
  end
end
