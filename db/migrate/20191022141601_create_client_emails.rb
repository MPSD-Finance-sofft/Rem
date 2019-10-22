class CreateClientEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :client_emails do |t|
      t.integer :client_id
      t.integer :email_id

      t.timestamps
    end
  end
end
